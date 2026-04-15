-- [[ 基础选项 ]]
-- 参考 `:help vim.o`
-- 这些选项都可以按自己的习惯调整。
-- 更多可选项可参考 `:help option-list`

-- 默认显示行号
vim.o.number = true
-- 也可以启用相对行号，方便跳转。
-- 可以自己试试是否符合习惯。
-- vim.o.relativenumber = true

-- 启用鼠标模式，例如可以直接拖拽调整分屏大小。
vim.o.mouse = "a"

-- 不再单独显示模式，状态栏里已经会显示。
vim.o.showmode = false

-- 同步系统剪贴板和 Neovim。
-- 因为可能影响启动速度，所以示例里放在 `UiEnter` 之后再设置。
-- 如果希望系统剪贴板和 Neovim 保持独立，就不要启用这项。
-- 参考 `:help 'clipboard'`
-- vim.schedule(function() vim.o.clipboard = "unnamedplus" end)

-- 启用断行后的缩进保持。
vim.o.breakindent = true

-- 关闭文件后仍然保留撤销历史。
vim.o.undofile = true

-- 搜索默认忽略大小写；如果模式里带 `\C` 或大写字母，则切换为区分大小写。
vim.o.ignorecase = true
vim.o.smartcase = true

-- 始终保留符号列，避免诊断或 Git 标记出现时界面抖动。
vim.o.signcolumn = "yes"

-- 缩短更新延迟。
vim.o.updatetime = 250

-- 缩短映射等待时间。
vim.o.timeoutlen = 300

-- 新分屏默认向右和向下打开。
vim.o.splitright = true
vim.o.splitbelow = true

-- 配置空白字符的显示方式。
-- 参考 `:help 'list'` 和 `:help 'listchars'`
--
-- 这里用 `vim.opt` 而不是 `vim.o` 设置 `listchars`。
-- 两者用途接近，但 `vim.opt` 更适合处理表类型的选项。
-- 参考 `:help lua-options` 和 `:help lua-guide-options`
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- 在输入替换命令时实时预览结果。
vim.o.inccommand = "split"

-- 高亮当前光标所在行。
vim.o.cursorline = true

-- 光标上下至少保留的屏幕行数。
vim.o.scrolloff = 10

-- 当操作会因未保存修改而失败时（例如 `:q`），
-- 改为弹出确认提示，而不是直接报错。
-- 参考 `:help 'confirm'`
vim.o.confirm = true
