vim.pack.add({
  {
    src = "https://github.com/pablopunk/pi.nvim",
  },
}, {
  load = true,
  confirm = false,
})

require("pi").setup()

vim.keymap.set("n", "<leader>ai", "<cmd>PiAsk<CR>", { desc = "询问 pi('ai' for 'Ask AI')" })
vim.keymap.set("v", "<leader>ai", "<cmd>PiAskSelection<CR>", { desc = "询问 pi 选中内容('ai' for 'Ask AI')" })
vim.keymap.set("n", "<leader>ac", "<cmd>PiCancel<CR>", { desc = "取消 pi 请求('ac' for 'Ask Cancel')" })
vim.keymap.set("n", "<leader>al", "<cmd>PiLog<CR>", { desc = "打开 pi 日志('al' for 'Ask Log')" })
