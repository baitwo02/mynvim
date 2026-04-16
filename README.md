# Neovim 配置

## 编写与更新规范
- `README.md` 面向配置使用者，重点写当前配置的结构、依赖、安装方式、已启用插件与 LSP、常用行为。
- 当入口、目录结构、插件列表、LSP 列表或安装前提发生变化时，优先同步更新这里。
- 介绍当前已生效的配置即可，不写未来计划，也不把代理协作规则混进来；代理侧约束放 `AGENTS.md`。
- 只写当前仓库里真实存在的内容；未安装的插件、未启用的 LSP、未提供的工作流不要提前写进 README。

## 简介
这是一个偏极简的个人 Neovim Lua 配置。

入口文件是 `init.lua`，启动时会依次加载：

1. `core.options`
2. `core.keymaps`
3. `core.autocommands`
4. `plugins`
5. `lsp`

当前配置依赖 Neovim 内置的 `vim.pack`、内置 LSP 和 `nvim-treesitter`；验证环境是 `NVIM v0.12.0-dev`。

## 目录结构
- `init.lua`: 总入口。
- `lua/core/`: 编辑器基础行为，包括选项、快捷键和自动命令。
- `lua/plugins/`: 单个插件的安装和配置。
- `lua/lsp/`: 单个语言服务器的配置。
- `nvim-pack-lock.json`: `vim.pack` 的插件锁定信息。

## 已启用插件

### `blink.cmp`
- 仓库: `https://github.com/saghen/blink.cmp`
- 用途: 补全
- 配置文件: `lua/plugins/blink.lua`
- 当前锁定在 `1.*`
- 使用默认键位预设，补全源包括 `lsp`、`path`、`snippets`、`buffer`

### `catppuccin`
- 仓库: `https://github.com/catppuccin/nvim`
- 用途: 主题
- 配置文件: `lua/plugins/catppuccin.lua`
- 启动时直接应用 `catppuccin-nvim`

### `mini.nvim`
- 仓库: `https://github.com/echasnovski/mini.nvim`
- 用途: 当前用于 `mini.statusline` 状态栏
- 配置文件: `lua/plugins/mini.lua`
- 当前只启用了 `mini.statusline`，并参考 kickstart 调整了光标位置段显示

### `noice.nvim`
- 仓库: `https://github.com/folke/noice.nvim`
- 用途: 消息、命令行、LSP 文档弹窗增强
- 配置文件: `lua/plugins/noice.lua`
- 依赖 `lua/plugins/nui.lua` 和 `lua/plugins/notify.lua` 单独装配
- 与 `catppuccin` 集成，统一浮窗和通知的配色风格

### `pi.nvim`
- 仓库: `https://github.com/pablopunk/pi.nvim`
- 用途: 在 Neovim 里调用 `pi` CLI
- 配置文件: `lua/plugins/pi.lua`
- 使用插件默认配置，直接复用用户已有的 `pi` provider / model 设置
- 提供 `:PiAsk`、`:PiAskSelection`、`:PiCancel`、`:PiLog` 命令，并配置了对应快捷键

### `flash.nvim`
- 仓库: `https://github.com/folke/flash.nvim`
- 用途: 当前窗口内快速跳转与 Treesitter 跳转
- 配置文件: `lua/plugins/flash.lua`
- 当前使用 `s` 作为普通跳转入口，`S` 作为 Treesitter 跳转入口
- 主题颜色走 `catppuccin` 的 `flash.nvim` 集成高亮

### `fzf-lua`
- 仓库: `https://github.com/ibhagwan/fzf-lua`
- 用途: 文件、内容、缓冲区与帮助文档搜索
- 配置文件: `lua/plugins/fzf.lua`
- 当前用于统一的搜索入口，提供 `files`、`live_grep`、`buffers`、`helptags`、`resume` 等 picker
- 主题颜色走 `catppuccin` 的 `fzf-lua` 集成高亮

### `which-key.nvim`
- 仓库: `https://github.com/folke/which-key.nvim`
- 用途: 快捷键提示
- 配置文件: `lua/plugins/which_key.lua`
- 输入前缀键时弹出可用快捷键提示

### `nvim-treesitter`
- 仓库: `https://github.com/nvim-treesitter/nvim-treesitter`
- 用途: 语法树高亮、折叠与缩进
- 配置文件: `lua/plugins/treesitter.lua`
- 通过 `FileType` 自动命令按需启用 `vim.treesitter.start()`
- 会为常用语言自动安装 parser，并在可用时启用 treesitter 缩进与 foldexpr
- `tree-sitter` CLI 需要用户在系统环境里手动安装，这个仓库不会代装

### `indent-blankline.nvim`
- 仓库: `https://github.com/lukas-reineke/indent-blankline.nvim`
- 用途: 缩进参考线
- 配置文件: `lua/plugins/indent_blankline.lua`
- 使用 `ibl` 入口配置多色但偏淡的缩进线
- 颜色基于 `catppuccin` 调色板混合生成，并启用基于 treesitter 的 `scope` 高亮

## 已启用 LSP

### `ty`
- 启动命令: `ty server`
- 配置文件: `lua/lsp/ty.lua`

### `lua_ls`
- 启动命令: `lua-language-server`
- 配置文件: `lua/lsp/lua_ls.lua`

### `rust_analyzer`
- 启动命令: `rust-analyzer`
- 配置文件: `lua/lsp/rust_analyzer.lua`

### `rime_ls`
- 启动命令: `rime_ls` 或 `rime-ls`
- 配置文件: `lua/lsp/rime_ls.lua`
- 在文档类文件中默认全局触发，在其他文件类型中默认用 `>` 触发补全
- 已按 `rime-ls` 文档补充 `blink.cmp` 相关配置
- 当前 `user_data_dir` 是 `~/.local/share/nvim/rime-ls`，可直接在这里安装 `rime-ice`

语言服务器需要用户自己在系统环境中安装，这个仓库只负责 Neovim 侧配置。

## 安装
1. 将仓库放到 `~/.config/nvim`。
2. 确保使用的 Neovim 版本支持 `vim.pack`、内置 `vim.lsp.config()` 和新版 `nvim-treesitter`。
3. 为 `nvim-treesitter` 手动安装系统依赖，并保证这些命令在 `PATH` 中可直接执行：`tar`、`curl`、`tree-sitter`，以及一个可用的 C 编译器。
4. 在系统环境里安装 `pi` CLI，并保证 `pi` 命令在 `PATH` 中可直接执行，例如：`npm install -g @mariozechner/pi-coding-agent`。
5. 按 `pi` 自身的方式完成登录或 API key 配置，并确认 `pi --list-models` 可以正常工作。
6. 为 `fzf-lua` 准备好外部命令，并保证这些命令在 `PATH` 中可直接执行：`fzf`；建议同时安装 `rg` 和 `fd` 以获得更好的内容搜索和文件搜索体验。
7. 如需使用 `rime_ls`，还需要在系统环境里安装 `rime_ls` 或 `rime-ls` 可执行文件，以及它依赖的 librime / rime-data；当前配置默认使用 `$RIME_DATA_DIR` 或 `/usr/share/rime-data` 作为共享数据目录。
8. 如需使用 `rime-ice`，可直接把它安装到 `rime_ls` 的用户目录：

```bash
rm -rf ~/.local/share/nvim/rime-ls
git clone https://github.com/iDvel/rime-ice.git ~/.local/share/nvim/rime-ls --depth 1
```

注意目标目录本身就是 `user_data_dir`，不要变成 `~/.local/share/nvim/rime-ls/rime-ice` 这种多套一层目录的结构。
9. 在系统环境里安装需要的语言服务器，并保证这些命令在 `PATH` 中可直接执行：`ty`、`lua-language-server`、`rust-analyzer`、`rime_ls`（或 `rime-ls`）。
10. 启动 `nvim`，让 `vim.pack` 按配置拉取插件；首次打开相关文件类型时，treesitter parser 会按配置自动安装。

## 默认行为
- `mapleader` 和 `maplocalleader` 都是空格。
- 默认启用行号、`breakindent`、`undofile`、`ignorecase` + `smartcase`、`cursorline`、`scrolloff=10`。
- 分屏默认向右和向下打开。
- 启用 `listchars`，当前显示为 `tab=» `、`trail=·`、`nbsp=␣`。
- 输入前缀键（例如 `<leader>`）时会通过 `which-key.nvim` 弹出可用快捷键提示。
- 状态栏当前使用 `mini.statusline`。
- `K` 的 LSP hover、命令行和通知会通过 `noice.nvim` / `nvim-notify` 以统一浮窗样式展示。
- 复制文本后会短暂高亮。
- 重新打开文件时会回到上次编辑位置。

## 默认快捷键
- `<Esc>`: 清除搜索高亮
- `<leader>q`: 打开诊断列表
- `<leader>ai`: 用当前缓冲区上下文询问 pi；可视模式下用选中内容询问 pi
- `<leader>ac`: 取消当前 pi 请求
- `<leader>al`: 打开 pi 日志
- `<leader>rr`: 切换 Rime 输入开关（rime_ls attach 后）
- `<leader>rs`: 同步 Rime 用户数据（rime_ls attach 后）
- `s`: Flash 普通跳转
- `S`: Flash Treesitter 跳转
- `r`: Flash 远程操作（operator-pending 模式）
- `R`: Flash Treesitter 搜索（可视 / operator-pending 模式）
- `<leader>ss`: 打开 fzf-lua 全局搜索入口
- `<leader>sf`: 搜索文件
- `<leader>sg`: 搜索项目内容
- `<leader>sw`: 搜索光标下单词
- `<leader>sb`: 搜索缓冲区
- `<leader>sh`: 搜索帮助文档
- `<leader>sr`: 恢复上次 fzf-lua 搜索
- `<leader>snh`: 打开 Noice 消息历史
- `<leader>snl`: 打开最近一条 Noice 消息
- `<leader>snd`: 清除当前 Noice 消息
- 终端模式下 `<Esc><Esc>`: 退出终端插入模式
- `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`: 在窗口间移动
- `K`: 显示 LSP hover 文档（LSP attach 后）
- `gd`, `gD`, `gi`, `gy`: LSP 跳转到定义 / 声明 / 实现 / 类型定义（LSP attach 后）
- `gr`: 通过 `fzf-lua` 列表查看 LSP 引用（LSP attach 后）
- `[d`, `]d`: 跳转到上一条 / 下一条诊断
- `<leader>ca`, `<leader>cr`: LSP 代码操作 / 重命名（LSP attach 后）
- `gh`, `gl`: 移动到行首和行尾

## 检查配置
最小检查命令：

```bash
nvim --headless "+qa"
```

这条命令只能验证配置是否能启动，不能替代交互式检查。
