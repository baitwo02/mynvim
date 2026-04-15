vim.lsp.config("ty", {
  cmd = { "ty", "server" },
  filetypes = { "python" },
  root_markers = {
    "ty.toml",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    ".git",
  },
  settings = {
    ty = {
      disableLanguageServices = false,
      diagnosticMode = "openFilesOnly",
      showSyntaxErrors = true,
      inlayHints = {
        variableTypes = true,
        callArgumentNames = true,
      },
      completions = {
        autoImport = true,
      },
      -- 项目级规则优先放到 ty.toml 或 pyproject.toml。
      configuration = {},
    },
  },
  init_options = {
    logLevel = "info",
  },
})

vim.lsp.enable("ty")
