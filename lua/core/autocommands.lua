-- [[ 基础自动命令 ]]
-- 参考 `:help lua-guide-autocommands`

-- 复制文本后短暂高亮对应区域。
-- 可以在普通模式下用 `yap` 试一下。
-- 参考 `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "复制文本后高亮",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- 重新打开文件时回到上次编辑位置。
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "重新打开文件时回到上次编辑位置",
  group = vim.api.nvim_create_augroup("last-position", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
