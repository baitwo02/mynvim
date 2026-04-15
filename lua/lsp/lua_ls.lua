local runtime_library = vim.api.nvim_get_runtime_file("", true)

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    ".git",
    "init.lua",
  },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = {
          "?.lua",
          "?/init.lua",
        },
      },
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = {
        enable = true,
      },
      hint = {
        enable = true,
        paramName = "All",
        setType = false,
      },
      workspace = {
        checkThirdParty = "Disable",
        library = runtime_library,
        maxPreload = 2000,
        preloadFileSize = 500,
      },
      format = {
        enable = false,
      },
      -- 项目级规则优先放到 .luarc.json 或 .luarc.jsonc。
    },
  },
})

vim.lsp.enable("lua_ls")
