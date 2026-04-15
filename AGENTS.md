# AGENTS

## 编写与更新规范
- `AGENTS.md` 面向后续代理协作，不面向最终使用者；只保留“改这份配置时容易误判或漏掉的事实”。
- 安装说明、使用方法、插件介绍、效果展示放 `README.md`，不要再塞回这里。
- 只写能从当前仓库直接验证的内容；配置结构、已启用插件、已启用 LSP、装配入口变化后要同步更新。
- 优先记录“应该怎么改”而不是“这个配置能做什么”。如果一条信息不影响后续改动方式，就省略。

## 文件定位
- 这是个人 Neovim 配置，不是常规应用仓库。`AGENTS.md` 只写改配置时容易踩坑的事实；安装说明、插件介绍、使用示例更适合放 `README`。

## 装配入口
- 启动入口是 `init.lua`，按顺序加载 `core.options`、`core.keymaps`、`core.autocommands`、`plugins`、`lsp`。改动不生效时先检查这里有没有接上。
- `lua/plugins/init.lua` 和 `lua/lsp/init.lua` 都只是手动 `require(...)` 列表；新增模块只建文件不够，还要在对应 `init.lua` 里补一行 `require`。

## 目录边界
- `lua/core/*.lua` 只放编辑器基础行为。插件安装和 LSP 配置不要混进 `core`。
- `lua/plugins/*.lua` 的职责是“安装并立刻配置单个插件”，不是收集插件 spec 列表。
- `lua/lsp/*.lua` 一文件对应一个语言服务器，直接在模块顶层写 `vim.lsp.config(...)` 和 `vim.lsp.enable(...)`。

## 现有风格
- 这个仓库偏向直接写法，不做额外封装：插件模块里直接 `vim.pack.add(...)`、`require(...).setup(...)`，LSP 模块里直接 `vim.lsp.config(...)`。新增配置优先沿用这种扁平风格。
- 不要引入 `lazy.nvim`、`packer.nvim` 之类替代插件管理器；这里用的是 Neovim 内置 `vim.pack`。
- 变更插件来源、名字或版本范围时，要同步看根目录的 `nvim-pack-lock.json`。
- Lua 字符串字面量当前统一优先使用双引号；只有在确实更合适时才使用单引号或长括号字面量。
- 如果双引号字符串里还需要再引用文本，优先把内层引号写成单引号，避免出现一串转义符。
- 快捷键 `desc` 如果包含助记说明，保留用户当前偏好的写法：使用英文圆括号和 `for`，例如 `("q" for "Quickfix")`，不要改写成中文括号或中文解释句式。

## 当前插件面
- 当前真正装配的插件只有两个：`blink.cmp` 和 `catppuccin`；不要假设仓库里已经有 `treesitter`、`telescope`、`gitsigns`、`nvim-tree` 等常见插件。
- `blink.cmp` 在 `lua/plugins/blink.lua` 中明确限制为 `1.*`；不要直接搬用 v2 配置。
- `catppuccin` 在模块顶层直接 `vim.cmd.colorscheme "catppuccin-nvim"`，所以主题配置错误会在启动阶段直接报，不是懒加载问题。
- `catppuccin` 的 `integrations` 里出现某些插件名，不代表这些插件已经安装；那只是主题侧的高亮开关。

## 当前 LSP 面
- LSP 用的是 Neovim 内置 `vim.lsp.config()` / `vim.lsp.enable()`，不是 `nvim-lspconfig` 的旧写法。
- 语言服务器由用户在系统环境里自行安装；这个仓库只负责 Neovim 侧配置，不负责下载、管理或包裹 LSP 可执行文件。
- 因此各 LSP 模块里的 `cmd` 应直接写语言服务器本身的启动命令，不要在这里额外加安装逻辑、探测包装或下载脚本。
- 当前启用了三个语言服务器：`ty`、`lua_ls`、`rust_analyzer`。对应模块分别是 `lua/lsp/ty.lua`、`lua/lsp/lua_ls.lua`、`lua/lsp/rust_analyzer.lua`。
- 这些 LSP 模块都保持“编辑器侧通用配置”，项目专用规则应放语言自己的配置文件里，不要硬编码进这个仓库。
- `lua_ls` 额外把 `init.lua` 作为根标记，因为这个配置目录未必总有 `.git`。
- `rust-analyzer` 可能命中 `~/.cargo/bin/rust-analyzer -> rustup` 代理；只有安装了 `rustup component add rust-analyzer` 后这个命令才真正可用。

## 改动后检查
- 这里只有一个通用检查方式：`nvim --headless "+qa"`。它只能验证配置能否启动，不能替代交互式功能检查。
