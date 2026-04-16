vim.pack.add({
  {
    src = "https://github.com/lukas-reineke/indent-blankline.nvim",
  },
}, {
  load = true,
  confirm = false,
})

local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

local hooks = require("ibl.hooks")

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  local colors = require("catppuccin.palettes").get_palette()
  local blend = require("catppuccin.utils.colors").blend
  local muted = function(color)
    return blend(color, colors.surface1, 0.45)
  end

  vim.api.nvim_set_hl(0, "RainbowRed", { fg = muted(colors.red) })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = muted(colors.yellow) })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = muted(colors.blue) })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = muted(colors.peach) })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = muted(colors.green) })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = muted(colors.mauve) })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = muted(colors.teal) })
  vim.api.nvim_set_hl(0, "IblScope", { fg = blend(colors.lavender, colors.surface1, 0.7) })
end)

require("ibl").setup({
  indent = {
    char = "│",
    highlight = highlight,
  },
  scope = {
    enabled = true,
    show_start = true,
    show_end = false,
    highlight = "IblScope",
  },
})
