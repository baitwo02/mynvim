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
    ["<A-1>"] = {
      function(cmp) cmp.accept({ index = 1 }) end,
    },
    ["<A-2>"] = {
      function(cmp) cmp.accept({ index = 2 }) end,
    },
    ["<A-3>"] = {
      function(cmp) cmp.accept({ index = 3 }) end,
    },
    ["<A-4>"] = {
      function(cmp) cmp.accept({ index = 4 }) end,
    },
    ["<A-5>"] = {
      function(cmp) cmp.accept({ index = 5 }) end,
    },
    ["<A-6>"] = {
      function(cmp) cmp.accept({ index = 6 }) end,
    },
    ["<A-7>"] = {
      function(cmp) cmp.accept({ index = 7 }) end,
    },
    ["<A-8>"] = {
      function(cmp) cmp.accept({ index = 8 }) end,
    },
    ["<A-9>"] = {
      function(cmp) cmp.accept({ index = 9 }) end,
    },
    ["<A-0>"] = {
      function(cmp) cmp.accept({ index = 10 }) end,
    },
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = { auto_show = false },
    menu = {
      draw = {
        columns = {
          { "item_idx" },
          { "kind_icon" },
          { "label", "label_description", gap = 1 },
        },
        components = {
          item_idx = {
            text = function(ctx)
              return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
            end,
            highlight = "BlinkCmpItemIdx",
          },
        },
      },
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    providers = {
      lsp = {
        transform_items = function(_, items)
          for _, item in ipairs(items) do
            if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
              item.score_offset = item.score_offset - 3
            end
          end
          return items
        end,
      },
    },
  },
})
