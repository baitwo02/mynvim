vim.pack.add({
  {
    src = "https://github.com/NMAC427/guess-indent.nvim",
  },
}, {
  load = true,
  confirm = false,
})

require("guess-indent").setup({})
