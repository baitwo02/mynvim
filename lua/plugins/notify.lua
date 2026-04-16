vim.pack.add({
  {
    src = "https://github.com/rcarriga/nvim-notify",
  },
}, {
  load = true,
  confirm = false,
})

require("notify").setup({
  background_colour = require("catppuccin.palettes").get_palette().base,
})
