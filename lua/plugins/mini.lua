vim.pack.add({
  {
    src = "https://github.com/echasnovski/mini.nvim",
  },
}, {
  load = true,
  confirm = false,
})

local statusline = require("mini.statusline")

statusline.setup({
  use_icons = vim.g.have_nerd_font == true,
})

statusline.section_location = function()
  return "%2l:%-2v"
end
