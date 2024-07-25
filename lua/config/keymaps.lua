-- 模式:
-- 普通模式 = [[n]],
-- 插入模式 = [[i]],
-- 选中模式 = [[v]],
-- 区块选中 = [[x]],
-- 终端模式 = [[t]],
-- 命令模式 = [[c]],

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- 取消一些按键的作用
keymap([[]], [[<Space>]], [[<Nop>]], { desc = [[No operation]], noremap = true, silent = true })
keymap([[]], [[s]], [[<nop>]], { desc = [[No operation]], noremap = true, silent = true })
keymap([[]], [[S]], [[<nop>]], { desc = [[No operation]], noremap = true, silent = true })
keymap([[]], [[x]], [[<nop>]], { desc = [[No operation]], noremap = true, silent = true })
keymap([[]], [[r]], [[<nop>]], { desc = [[No operation]], noremap = true, silent = true })
keymap([[]], [[q]], [[<nop>]], { desc = [[No operation]], noremap = true, silent = true })
keymap([[]], [[<cr>]], [[<nop>]], { desc = [[No operation]], noremap = true, silent = true })

-- 将 space 键设置为 leader 键
vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[ ]]

-- 保存与退出
keymap({ [[n]], [[v]] }, [[<leader>ss]], [[<cmd>w<cr>]], { desc = [[Save file]], noremap = true, silent = true })
keymap({ [[n]], [[v]] }, [[<leader>qq]], [[<cmd>q<cr>]], { desc = [[Quit file]], noremap = true, silent = true })

-- 窗口导航
keymap([[n]], [[<c-h>]], [[<c-w>h]], { desc = [[Focus left window]], noremap = true, silent = true })
keymap([[n]], [[<c-j>]], [[<c-w>j]], { desc = [[Focus down window]], noremap = true, silent = true })
keymap([[n]], [[<c-k>]], [[<c-w>k]], { desc = [[Focus up window]], noremap = true, silent = true })
keymap([[n]], [[<c-l>]], [[<c-w>l]], { desc = [[Focus right window]], noremap = true, silent = true })
keymap([[n]], [[<c-s-h>]], [[<c-w>H]], { desc = [[Move window left]], noremap = true, silent = true })
keymap([[n]], [[<c-s-j>]], [[<c-w>J]], { desc = [[Move window down]], noremap = true, silent = true })
keymap([[n]], [[<c-s-k>]], [[<c-w>K]], { desc = [[Move window up]], noremap = true, silent = true })
keymap([[n]], [[<c-s-l>]], [[<c-w>L]], { desc = [[Move window right]], noremap = true, silent = true })

-- 分屏
keymap([[n]], [[<leader>wh]], [[<cmd>set nosplitright<cr><cmd>vsplit<cr>]], { desc = [[Split window left]], noremap = true, silent = true })
keymap([[n]], [[<leader>wj]], [[<cmd>set splitbelow<cr><cmd>split<cr>]], { desc = [[Split window down]], noremap = true, silent = true })
keymap([[n]], [[<leader>wk]], [[<cmd>set nosplitbelow<cr><cmd>split<cr>]], { desc = [[Split window up]], noremap = true, silent = true })
keymap([[n]], [[<leader>wl]], [[<cmd>set splitright<cr><cmd>vsplit<cr>]], { desc = [[Split window right]], noremap = true, silent = true })

-- 通过方向键重新设置窗口大小
keymap([[n]], [[<c-up>]], [[:resize -2<cr>]], { desc = [[Decrease window height]], noremap = true, silent = true })
keymap([[n]], [[<c-down>]], [[:resize +2<cr>]], { desc = [[Increase window height]], noremap = true, silent = true })
keymap([[n]], [[<c-left>]], [[:vertical resize -2<cr>]], { desc = [[Decrease window width]], noremap = true, silent = true })
keymap([[n]], [[<c-right>]], [[:vertical resize +2<cr>]], { desc = [[Increase window width]], noremap = true, silent = true })

-- buffers 导航
keymap([[n]], [[<leader>bj]], [[:bnext<cr>]], { desc = [[Next buffer]], noremap = true, silent = true })
keymap([[n]], [[<leader>bk]], [[:bprevious<cr>]], { desc = [[Previous buffer]], noremap = true, silent = true })

-- tab 导航
keymap([[n]], [[tn]], [[:tabnew ]], { desc = [[New tab]], noremap = true, silent = true })
keymap([[n]], [[tj]], [[gt]], { desc = [[Next tab]], noremap = true, silent = true })
keymap([[n]], [[tk]], [[gT]], { desc = [[Previous tab]], noremap = true, silent = true })

-- 上下移动文本
keymap([[n]], [[<A-j>]], [[<cmd>m .+1<cr>==]], { desc = [[Move line down]], noremap = true, silent = true })
keymap([[n]], [[<A-k>]], [[<cmd>m .-2<cr>==]], { desc = [[Move line up]], noremap = true, silent = true })
keymap([[i]], [[<A-j>]], [[<esc><cmd>m .+1<cr>==gi]], { desc = [[Move line down]], noremap = true, silent = true })
keymap([[i]], [[<A-k>]], [[<esc><cmd>m .-2<cr>==gi]], { desc = [[Move line up]], noremap = true, silent = true })
keymap([[v]], [[<A-j>]], [[:m '>+1<cr>gv=gv]], { desc = [[Move selection down]], noremap = true, silent = true })
keymap([[v]], [[<A-k>]], [[:m '<-2<cr>gv=gv]], { desc = [[Move selection up]], noremap = true, silent = true })

-- 移动光标
keymap({ [[n]], [[x]] }, [[j]], [[v:count == 0 ? 'gj' : 'j']], { desc = [[Down]], expr = true, silent = true })
keymap({ [[n]], [[x]] }, [[<Down>]], [[v:count == 0 ? 'gj' : 'j']], { desc = [[Down]], expr = true, silent = true })
keymap({ [[n]], [[x]] }, [[k]], [[v:count == 0 ? 'gk' : 'k']], { desc = [[Up]], expr = true, silent = true })
keymap({ [[n]], [[x]] }, [[<Up>]], [[v:count == 0 ? 'gk' : 'k']], { desc = [[Up]], expr = true, silent = true })
keymap([[n]], [[gh]], [[^]], { desc = [[Move to start of line]], noremap = true, silent = true })
keymap([[n]], [[gl]], [[$]], { desc = [[Move to end of line]], noremap = true, silent = true })

keymap([[v]], [[gh]], [[^]], { desc = [[Move to start of line]], noremap = true, silent = true })
keymap([[v]], [[gl]], [[$h]], { desc = [[Move to end of line]], noremap = true, silent = true })

keymap([[i]], [[;;]], [[<esc>la]], { desc = [[Exit insert mode and move right]], noremap = true, silent = true })

-- 复制粘贴
keymap({ [[n]] , [[v]] , [[x]] }, [[y]], [["+y]], { desc = [[Yank to system clipboard]], noremap = true, silent = true })
keymap({ [[n]] , [[v]] , [[x]] }, [[Y]], [["+Y]], { desc = [[Yank to system clipboard]], noremap = true, silent = true })
keymap({ [[n]] , [[v]] , [[x]] }, [[p]], [["+p]], { desc = [[Paste from system clipboard]], noremap = true, silent = true })
keymap({ [[n]] , [[v]] , [[x]] }, [[P]], [["+P]], { desc = [[Paste from system clipboard]], noremap = true, silent = true })
keymap({ [[n]] , [[v]] , [[x]] }, [[<leader>y]], [[y]], { desc = [[Yank to default register]], noremap = true, silent = true })
keymap({ [[n]] , [[v]] , [[x]] }, [[<leader>Y]], [[Y]], { desc = [[Yank to default register]], noremap = true, silent = true })
keymap({ [[n]] , [[v]] , [[x]] }, [[<leader>p]], [[p]], { desc = [[Paste from default register]], noremap = true, silent = true })
keymap({ [[n]] , [[v]] , [[x]] }, [[<leader>P]], [[P]], { desc = [[Paste from default register]], noremap = true, silent = true })

-- 按 jk 键退出 insert 模式
keymap([[i]], [[jk]], [[<esc>]], { desc = [[Exit insert mode]], noremap = true, silent = true })
keymap([[i]], [[kj]], [[<esc>]], { desc = [[Exit insert mode]], noremap = true, silent = true })
keymap([[t]], [[<esc>]], [[<C-\><C-N>]], { desc = [[Exit terminal mode]], noremap = true, silent = true })

-- 调整缩进
keymap([[v]], [[<]], [[<gv]], { desc = [[Decrease indent]], noremap = true, silent = true })
keymap([[v]], [[>]], [[>gv]], { desc = [[Increase indent]], noremap = true, silent = true })

