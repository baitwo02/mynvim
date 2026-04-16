vim.pack.add({
  {
    src = "https://github.com/ibhagwan/fzf-lua",
  },
}, {
  load = true,
  confirm = false,
})

require("fzf-lua").setup({
  "default-title",
  winopts = {
    height = 0.85,
    width = 0.80,
    row = 0.35,
    col = 0.50,
    border = "rounded",
    preview = {
      border = "rounded",
      layout = "flex",
      vertical = "down:45%",
      horizontal = "right:60%",
      title = true,
      title_pos = "center",
    },
  },
  oldfiles = {
    include_current_session = true,
  },
})

vim.keymap.set("n", "<leader>ss", function()
  require("fzf-lua").global()
end, { desc = "打开全局搜索入口('ss' for 'Search Selector')" })

vim.keymap.set("n", "<leader>sf", function()
  require("fzf-lua").files()
end, { desc = "搜索文件('sf' for 'Search Files')" })

vim.keymap.set("n", "<leader>sg", function()
  require("fzf-lua").live_grep()
end, { desc = "搜索项目内容('sg' for 'Search Grep')" })

vim.keymap.set("n", "<leader>sw", function()
  require("fzf-lua").grep_cword()
end, { desc = "搜索光标下单词('sw' for 'Search Word')" })

vim.keymap.set("n", "<leader>sb", function()
  require("fzf-lua").buffers()
end, { desc = "搜索缓冲区('sb' for 'Search Buffers')" })

vim.keymap.set("n", "<leader>sh", function()
  require("fzf-lua").helptags()
end, { desc = "搜索帮助文档('sh' for 'Search Help')" })

vim.keymap.set("n", "<leader>sr", function()
  require("fzf-lua").resume()
end, { desc = "恢复上次搜索('sr' for 'Search Resume')" })
