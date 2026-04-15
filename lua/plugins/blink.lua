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
  keymap = {
    preset = "none",
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<CR>"] = { "accept", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<C-j>"] = { "snippet_forward", "fallback" },
    ["<C-k>"] = { "snippet_backward", "fallback" },
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
  },
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
