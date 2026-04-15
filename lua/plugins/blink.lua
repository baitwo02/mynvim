-- 安装 blink.cmp v1
vim.pack.add({
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },
}, {
  load = true,
  confirm = false,
})

-- 配置 blink.cmp
require("blink.cmp").setup({
  keymap = { preset = "default" },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = { auto_show = false },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
})
