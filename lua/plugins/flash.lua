vim.pack.add({
  {
    src = "https://github.com/folke/flash.nvim",
  },
}, {
  load = true,
  confirm = false,
})

require("flash").setup()

vim.keymap.set({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash 跳转('s' for 'Search jump')" })

vim.keymap.set({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter 跳转('S' for 'Syntax tree')" })

vim.keymap.set("o", "r", function()
  require("flash").remote()
end, { desc = "Flash 远程操作('r' for 'Remote')" })

vim.keymap.set({ "x", "o" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "Flash Treesitter 搜索('R' for 'Remote treesitter search')" })
