-- [[ 基础快捷键 ]]
-- 参考 `:help vim.keymap.set()`

-- 普通模式按 `<Esc>` 时清除搜索高亮。
-- 参考 `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- 诊断配置和相关快捷键。
-- 参考 `:help vim.diagnostic.Opts`
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- 这两种展示方式可以按喜好切换。
  virtual_text = true, -- 诊断文本显示在行尾。
  virtual_lines = false, -- 诊断文本显示在代码下方的虚拟行里。

  -- 用 `[d` 和 `]d` 跳转诊断时自动打开浮窗，方便直接查看内容。
  jump = { float = true },
}

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "打开诊断位置列表('q' for 'Quickfix')" })

-- 给内置终端补一个更容易记住的退出快捷键。
-- 否则默认需要按 `<C-\\><C-n>`，这个组合不太直观。
--
-- 注意：这个映射不一定在所有终端或 tmux 环境里都生效。
-- 如果冲突，就改成自己的映射，或者继续使用 `<C-\\><C-n>`。
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "退出终端模式" })

-- 提示：如果想强制自己使用 `hjkl`，可以禁用方向键。
-- vim.keymap.set("n", "<left>", "<cmd>echo '请用 h 移动'<CR>")
-- vim.keymap.set("n", "<right>", "<cmd>echo '请用 l 移动'<CR>")
-- vim.keymap.set("n", "<up>", "<cmd>echo '请用 k 移动'<CR>")
-- vim.keymap.set("n", "<down>", "<cmd>echo '请用 j 移动'<CR>")

-- 用 `Ctrl + hjkl` 在窗口之间切换，和普通模式移动方向保持一致。
-- 参考 `:help wincmd`
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "将焦点移到左侧窗口('h' for 'left')" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "将焦点移到右侧窗口('l' for 'right')" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "将焦点移到下方窗口('j' for 'down')" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "将焦点移到上方窗口('k' for 'up')" })

-- 注意：有些终端会让这类组合键冲突，或者根本发不出可区分的按键码。
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "把窗口移到左侧" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "把窗口移到右侧" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "把窗口移到下方" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "把窗口移到上方" })

vim.keymap.set({ "n", "v" }, "gh", "^", { desc = "移动到行首('gh' for 'Go Head')" })
vim.keymap.set({ "n", "v" }, "gl", "g_", { desc = "移动到行尾最后一个非空字符('gl' for 'Go Last')" })
