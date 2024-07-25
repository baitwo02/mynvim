vim.opt.autochdir = false
vim.opt.backup = true -- 允许创建备份文件
vim.opt.swapfile = true -- 允许创建交换文件
vim.opt.undofile = true -- 允许创建撤销文件

local function ensure_dir(dir)
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
end

local backup_dir = vim.fn.stdpath("data") .. "/backup"
local swap_dir = vim.fn.stdpath("data") .. "/swap"
local undo_dir = vim.fn.stdpath("data") .. "/undo"

ensure_dir(backup_dir)
ensure_dir(swap_dir)
ensure_dir(undo_dir)

vim.opt.backupdir = backup_dir -- 备份文件路径
vim.opt.directory = swap_dir -- 交换文件路径
vim.opt.undodir = undo_dir -- 撤销文件路径

vim.opt.fileencoding = "utf-8" -- 文件使用 utf8 编码
vim.opt.writebackup = false -- 一个文件正在被编辑, 禁止写备份文件

-- 操作
vim.opt.mouse = "a" -- 允许使用鼠标

-- 搜索
vim.opt.hlsearch = true -- 高亮搜索内容
vim.opt.ignorecase = true -- 搜索是忽略大小写
vim.opt.smartcase = true -- 搜索时智能大小写

-- 缩进
vim.opt.showtabline = 2 -- 总是显示 tabs
vim.opt.tabstop = 2 -- 一个 tab 符号占用空格数量
vim.opt.shiftwidth = 2 -- 每次缩进所插入的空格数量
vim.opt.expandtab = true -- 将 tab 转换为空格
vim.opt.smartindent = true -- 让缩进更智能

-- 折叠
vim.opt.foldmethod = "indent" -- 使用 indent 模式折叠
vim.opt.foldenable = false -- 当打开一个文件时不允许应用折叠
vim.opt.foldlevel = 99 -- 不设置这个, 到处都会有折叠

-- 界面
vim.opt.number = true -- 显示每行数字
vim.opt.relativenumber = false -- 每行前面的数字设置为相对数字
vim.opt.wrap = true -- 展示不完的行会换行展示
vim.opt.cursorline = true -- 高亮鼠标所在行: ture
vim.opt.cursorcolumn = false -- 高亮鼠标所在列: false
vim.opt.cmdheight = 1 -- 状态栏高度
vim.opt.conceallevel = 0 -- 在 markdown 文件中 `` 符号可见
vim.opt.pumheight = 10 -- pop 菜单的高度
vim.opt.showmode = true -- 显示现在模式
vim.opt.termguicolors = true -- 设置允许终端颜色(大部分终端支持此设计)
vim.opt.timeoutlen = 500 -- 映射序列允许的间隔时间
vim.opt.updatetime = 300 -- faster completion (4000ms default)
vim.opt.numberwidth = 4 -- 设置数字列的宽度为2(默认为4)
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.scrolloff = 8 -- 顶部和底部至少会显示8行
vim.opt.sidescrolloff = 8 -- 左右至少会显示8列
vim.opt.guifont = "hack nerd font mono:h17" -- 图形化 neovim 使用的字体
vim.opt.listchars = { tab = "󰌒 ", extends = "", precedes = "", trail = "~", eol = "󰑁" }
vim.opt.showbreak = "↪ "

vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })

