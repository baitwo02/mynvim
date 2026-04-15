vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = {
    "Cargo.toml",
    "rust-project.json",
    ".git",
  },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allTargets = true,
        buildScripts = {
          enable = true,
        },
      },
      checkOnSave = true,
      check = {
        command = "check",
      },
      completion = {
        autoimport = {
          enable = true,
        },
        callable = {
          snippets = "fill_arguments",
        },
      },
      diagnostics = {
        enable = true,
      },
      procMacro = {
        enable = true,
      },
      inlayHints = {
        chainingHints = {
          enable = true,
        },
        closingBraceHints = {
          enable = true,
          minLines = 25,
        },
        parameterHints = {
          enable = true,
        },
        typeHints = {
          enable = true,
        },
      },
    },
  },
})

vim.lsp.enable("rust_analyzer")
