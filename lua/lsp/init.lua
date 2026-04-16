-- 这里的 LSP 模块只负责 Neovim 侧配置。
-- 对应语言服务器需要用户自己安装，并确保命令在 PATH 中可直接执行。

local rime_document_filetypes = {
  markdown = true,
  text = true,
  tex = true,
  typst = true,
}

local function set_rime_trigger(client, buf)
  local trigger_characters = rime_document_filetypes[vim.bo[buf].filetype] and {} or { ">" }
  local settings = { trigger_characters = trigger_characters }

  client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, settings)
  client:notify("workspace/didChangeConfiguration", { settings = settings })
end

local function toggle_rime(client)
  client:request("workspace/executeCommand", { command = "rime-ls.toggle-rime" }, function(_, result, ctx)
    if ctx.client_id == client.id then
      vim.g.rime_enabled = result
    end
  end)
end

-- LSP 附着后，给当前缓冲区设置通用快捷键。
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP 附着后配置通用快捷键",
  group = vim.api.nvim_create_augroup("lsp-keymaps", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
    end

    map("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, "跳到上一条诊断('[d' for 'diagnostic')")
    map("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, "跳到下一条诊断(']d' for 'diagnostic')")

    if client.name == "rime_ls" then
      set_rime_trigger(client, args.buf)
      map("n", "<leader>rr", function()
        toggle_rime(client)
      end, "切换 Rime 输入('rr' for 'Rime toggle')")
      map("n", "<leader>rs", function()
        vim.lsp.buf.execute_command({ command = "rime-ls.sync-user-data" })
      end, "同步 Rime 用户数据('rs' for 'Rime Sync')")
    end

    if client:supports_method("textDocument/hover") then
      map("n", "K", vim.lsp.buf.hover, "显示 hover 文档('K' for 'Keyword docs')")
    end
    if client:supports_method("textDocument/definition") then
      map("n", "gd", vim.lsp.buf.definition, "跳到定义('gd' for 'Goto Definition')")
    end
    if client:supports_method("textDocument/declaration") then
      map("n", "gD", vim.lsp.buf.declaration, "跳到声明('gD' for 'Goto Declaration')")
    end
    if client:supports_method("textDocument/implementation") then
      map("n", "gi", vim.lsp.buf.implementation, "跳到实现('gi' for 'Goto Implementation')")
    end
    if client:supports_method("textDocument/typeDefinition") then
      map("n", "gy", vim.lsp.buf.type_definition, "跳到类型定义('gy' for 'Goto tYpe definition')")
    end
    if client:supports_method("textDocument/references") then
      map("n", "gr", function()
        local ok, fzf_lua = pcall(require, "fzf-lua")
        if ok then
          fzf_lua.lsp_references()
          return
        end
        vim.lsp.buf.references()
      end, "查看引用('gr' for 'Goto References')")
    end
    if client:supports_method("textDocument/codeAction") then
      map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "代码操作('ca' for 'Code Action')")
    end
    if client:supports_method("textDocument/rename") then
      map("n", "<leader>cr", vim.lsp.buf.rename, "重命名符号('cr' for 'Code Rename')")
    end
  end,
})

-- 需要安装 `ty`，并保证 `ty server` 可直接执行。
require("lsp.ty")

-- 需要安装 `lua-language-server`，并保证该命令可直接执行。
require("lsp.lua_ls")

-- 需要安装 `rust-analyzer`，并保证该命令可直接执行。
require("lsp.rust_analyzer")

-- 需要安装 `rime_ls` 或 `rime-ls`，并保证其一可直接执行。
require("lsp.rime_ls")
