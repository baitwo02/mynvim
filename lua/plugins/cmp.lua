return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "neovim/nvim-lspconfig",  -- 提供LSP配置
    "hrsh7th/cmp-nvim-lsp",   -- 提供LSP补全源
    "hrsh7th/cmp-buffer",     -- 提供缓冲区补全源
    "hrsh7th/cmp-path",       -- 提供路径补全源
    "hrsh7th/cmp-cmdline",    -- 提供命令行补全源
    "nvimdev/lspsaga.nvim",   -- 提供LSP UI增强
    "L3MON4D3/LuaSnip",       -- 提供代码片段
    "saadparwaiz1/cmp_luasnip", -- 提供LuaSnip补全源
  },
  config = function()

    -- lspsaga 配置
    require('lspsaga').setup({})

    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local compare = require("cmp.config.compare")

    -- 检查光标前是否有非空白字符
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    -- 补全项的图标
    local kind_icons = {
      Text = " 󰉿 ",
      Method = " 󰆧 ",
      Function = " 󰊕 ",
      Constructor = "  ",
      Field = " 󰜢 ",
      Variable = " 󰀫 ",
      Class = " 󰠱 ",
      Interface = "  ",
      Module = "  ",
      Property = " 󰜢 ",
      Unit = " 󰑭 ",
      Value = " 󰎠 ",
      Enum = "  ",
      Keyword = " 󰌋 ",
      Snippet = "  ",
      Color = " 󰏘 ",
      File = " 󰈙 ",
      Reference = " 󰈇 ",
      Folder = " 󰉋 ",
      EnumMember = "  ",
      Constant = " 󰏿 ",
      Struct = " 󰙅 ",
      Event = "  ",
      Operator = " 󰆕 ",
      TypeParameter = " 󰅲 ",
    }

    cmp.setup({
      window = {
        completion = {
          winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
          col_offset = -3,
          side_padding = 0,
          border = 'rounded',
          scrollbar = true,
        },
        documentation = {
          winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
          border = 'rounded',
          scrollbar = true,
        },
      },

      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(_, vim_item)
          vim_item.menu = ' ' .. (vim_item.kind or '')
          vim_item.kind = kind_icons[vim_item.kind] or ''
          return vim_item
        end,
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- 设置快捷键
      mapping = cmp.mapping.preset.insert({
        ["<tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<s-tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["jj"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["kk"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<c-b>"] = cmp.mapping.scroll_docs(-4),
        ["<c-f>"] = cmp.mapping.scroll_docs(4),
        ["<c-e>"] = cmp.mapping.abort(),
        ["<cr>"] = cmp.mapping.confirm({ select = true }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),

      sorting = {
        comparators = {
          compare.sort_text,
          compare.offset,
          compare.exact,
          compare.score,
          compare.recently_used,
          compare.kind,
          compare.length,
          compare.order,
        },
      },

    })

    -- 配置git相关, 需要下载对应插件
    -- cmp.setup.filetype("gitcommit", {
    --     sources = cmp.config.sources({
    --         { name = "cmp_git" },
    --         { name = "buffer" },
    --     })
    -- })

    -- 让 / ? 命令能够使用 buffer 补全
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- 让 : 命令能使用 path cmdline 补全
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
      }),
    })

    -- 设置 Rime 输入法
    local function setup_rime()
      -- 全局状态
      vim.g.rime_enabled = false

      -- 更新 lualine 状态栏
      local function rime_status()
        if vim.g.rime_enabled then
          return 'ㄓ'
        else
          return ''
        end
      end

      require('lualine').setup({
        sections = {
          lualine_x = { rime_status, 'encoding', 'fileformat', 'filetype' },
        }
      })

      -- 添加 rime-ls 作为自定义 LSP 服务器
      local lspconfig = require('lspconfig')
      local configs = require('lspconfig.configs')
      if not configs.rime_ls then
        configs.rime_ls = {
          default_config = {
            name = "rime_ls",
            cmd = { 'rime_ls' },
            filetypes = { '*' },
            single_file_support = true,
          },
          settings = {},
          docs = {
            description = [[
            https://www.github.com/wlh320/rime-ls

            A language server for librime
            ]],
          }
        }
      end

      local rime_on_attach = function(client, _)
        local toggle_rime = function()
          client.request('workspace/executeCommand',
            { command = "rime-ls.toggle-rime" },
            function(_, result, ctx, _)
              if ctx.client_id == client.id then
                vim.g.rime_enabled = result
              end
            end
          )
        end
        -- 设置切换 Rime 的快捷键
        vim.keymap.set('n', '<leader>ri', function() toggle_rime() end)
        vim.keymap.set('i', '<C-x>', function() toggle_rime() end)
        vim.keymap.set('n', '<leader>rs', function() vim.lsp.buf.execute_command({ command = "rime-ls.sync-user-data" }) end)
      end

      -- 广播 nvim-cmp 的额外补全能力给服务器
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      lspconfig.rime_ls.setup {
        init_options = {
          enabled = vim.g.rime_enabled,
          shared_data_dir = "/usr/share/rime-data",
          user_data_dir = "~/.local/share/rime-ls",
          log_dir = "~/.local/share/rime-ls",
          max_candidates = 9,
          trigger_characters = {},
          schema_trigger_character = "&" -- [since v0.2.0] 当输入此字符串时请求补全会触发 “方案选单”
        },
        on_attach = rime_on_attach,
        capabilities = capabilities,
      }
    end

    setup_rime()
  end
}
