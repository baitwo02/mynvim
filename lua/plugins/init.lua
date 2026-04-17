-- 这里的插件模块只负责 Neovim 侧配置。
-- 插件依赖的外部命令或系统工具需要用户自己安装，并确保命令在 PATH 中可直接执行。

require("plugins.blink")

require("plugins.autopairs")

require("plugins.catppuccin")

require("plugins.guess_indent")

require("plugins.mini")

-- 下面这三个模块是一套消息与弹窗 UI 配置，放在一起维护。
require("plugins.nui")
require("plugins.notify")
require("plugins.noice")

-- 需要安装 `pi`，并保证该命令可直接执行。
require("plugins.pi")

require("plugins.flash")

-- 需要安装 `fzf`，建议安装 `rg` 和 `fd`，并保证这些命令可直接执行。
require("plugins.fzf")

require("plugins.which_key")

-- 需要安装 `tree-sitter`，并保证该命令可直接执行。
require("plugins.treesitter")

require("plugins.indent_blankline")
