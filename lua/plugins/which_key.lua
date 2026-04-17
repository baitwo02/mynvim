vim.pack.add({
  {
    src = "https://github.com/folke/which-key.nvim",
  },
}, {
  load = true,
  confirm = false,
})

require("which-key").setup({
  preset = "classic",
  delay = 300,
  win = {
    border = "rounded",
  },
  spec = {
    { "<leader>", group = "Leader" },
    { "<leader>a", group = "AI" },
    { "<leader>c", group = "Code" },
    { "<leader>e", group = "Explorer" },
    { "<leader>r", group = "Rime" },
    { "<leader>s", group = "Search" },
    { "<leader>sn", group = "Noice" },
  },
})
