vim.pack.add({
  {
    src = "https://github.com/catppuccin/nvim",
    name = "catppuccin",
  },
})

require("catppuccin").setup({
  flavour = "auto", -- 可选值：latte、frappe、macchiato、mocha
  background = { -- 参考 `:h background`
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false, -- 不设置背景色。
  float = {
    transparent = false, -- 浮窗使用透明背景。
    solid = false, -- 浮窗使用纯色边框风格，参考 `:h winborder`
  },
  term_colors = false, -- 设置终端颜色，例如 `g:terminal_color_0`
  dim_inactive = {
    enabled = false, -- 调暗非活动窗口的背景色。
    shade = "dark",
    percentage = 0.15, -- 调暗比例。
  },
  no_italic = false, -- 强制关闭斜体。
  no_bold = false, -- 强制关闭粗体。
  no_underline = false, -- 强制关闭下划线。
  styles = { -- 通用高亮组的样式，参考 `:h highlight-args`
    comments = { "italic" }, -- 注释使用斜体。
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
    -- miscs = {}, -- 取消注释即可关闭内置的固定样式。
  },
  lsp_styles = { -- LSP 相关高亮组的样式，参考 `:h lsp-highlight`
    virtual_text = {
      errors = { "italic" },
      hints = { "italic" },
      warnings = { "italic" },
      information = { "italic" },
      ok = { "italic" },
    },
    underlines = {
      errors = { "underline" },
      hints = { "underline" },
      warnings = { "underline" },
      information = { "underline" },
      ok = { "underline" },
    },
    inlay_hints = {
      background = true,
    },
  },
  color_overrides = {},
  custom_highlights = {},
  default_integrations = true,
  auto_integrations = false,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    notify = false,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
    -- 更多插件集成配置可参考：https://github.com/catppuccin/nvim#integrations
  },
})

-- 必须先执行 `setup`，再应用主题。
vim.cmd.colorscheme "catppuccin-nvim"
