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

当前配置依赖 Neovim 内置的 `vim.pack` 和内置 LSP；验证环境是 `NVIM v0.12.0-dev`。

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

语言服务器需要用户自己在系统环境中安装，这个仓库只负责 Neovim 侧配置。

## 安装
1. 将仓库放到 `~/.config/nvim`。
2. 确保使用的 Neovim 版本支持 `vim.pack` 和内置 `vim.lsp.config()`。
3. 在系统环境里安装需要的语言服务器，并保证这些命令在 `PATH` 中可直接执行：`ty`、`lua-language-server`、`rust-analyzer`。
4. 启动 `nvim`，让 `vim.pack` 按配置拉取插件。

## 默认行为
- `mapleader` 和 `maplocalleader` 都是空格。
- 默认启用行号、`breakindent`、`undofile`、`ignorecase` + `smartcase`、`cursorline`、`scrolloff=10`。
- 分屏默认向右和向下打开。
- 启用 `listchars`，当前显示为 `tab=» `、`trail=·`、`nbsp=␣`。
- 复制文本后会短暂高亮。
- 重新打开文件时会回到上次编辑位置。

## 默认快捷键
- `<Esc>`: 清除搜索高亮
- `<leader>q`: 打开诊断列表
- 终端模式下 `<Esc><Esc>`: 退出终端插入模式
- `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`: 在窗口间移动
- `gh`, `gl`: 移动到行首和行尾

## 检查配置
最小检查命令：

```bash
nvim --headless "+qa"
```

这条命令只能验证配置是否能启动，不能替代交互式检查。
