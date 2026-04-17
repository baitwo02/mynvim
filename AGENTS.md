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
- 当前真正装配的插件包括：`blink.cmp`、`nvim-autopairs`、`catppuccin`、`guess-indent.nvim`、`mini.nvim`、`noice.nvim`、`nvim-notify`、`which-key.nvim`、`pi.nvim`、`flash.nvim`、`fzf-lua`、`nvim-treesitter`、`indent-blankline.nvim`，以及 `noice.nvim` 依赖的 `nui.nvim`；不要假设仓库里已经有 `telescope`、`gitsigns`、`nvim-tree` 等常见插件。
- `blink.cmp` 在 `lua/plugins/blink.lua` 中明确限制为 `1.*`；不要直接搬用 v2 配置。
- `blink.cmp` 已为 `rime_ls` 做过 provider 级 `lsp.transform_items` 调整，目的是兼容 rime-ls 的 Text 类型候选和 `long_filter_text`；再改 LSP source 过滤逻辑时要一起回看 `lua/lsp/rime_ls.lua`。
- `catppuccin` 在模块顶层直接 `vim.cmd.colorscheme "catppuccin-nvim"`，所以主题配置错误会在启动阶段直接报，不是懒加载问题。
- `catppuccin` 的 `integrations` 里出现某些插件名，不代表这些插件已经安装；那只是主题侧的高亮开关。
- 现在 `catppuccin` 已显式打开 `flash`、`noice` 和 `notify` 集成；`mini` 集成也终于对应到了真实安装的 `mini.nvim`。如果替换这些 UI，记得一起检查这里。
- `nvim-autopairs` 配在 `lua/plugins/autopairs.lua`，当前只做 `require("nvim-autopairs").setup({})` 的最小配置，没有额外接 blink/cmp 的确认事件；如果以后要补全联动，先回看 blink 自己的 accept / auto brackets 行为，避免重复加括号。
- `guess-indent.nvim` 配在 `lua/plugins/guess_indent.lua`，当前只做 `require("guess-indent").setup({})` 的最小配置；它负责按已打开文件内容推断缩进选项，不替代 `core.options` 里的默认缩进基线。
- `mini.nvim` 配在 `lua/plugins/mini.lua`，当前启用了 `mini.statusline` 和 `mini.files`；以后如果继续加 `mini` 模块，优先仍放在这个插件模块里集中配置。
- `noice.nvim` 配在 `lua/plugins/noice.lua`；`nui.nvim` 和 `nvim-notify` 分别拆在 `lua/plugins/nui.lua`、`lua/plugins/notify.lua`，并在 `lua/plugins/init.lua` 里作为一组连续 `require(...)` 维护。LSP 文档、命令行和通知的 UI 调整优先在这里改。
- `which-key.nvim` 配在 `lua/plugins/which_key.lua`，直接 `require("which-key").setup(...)`；现有快捷键提示主要依赖各映射上的 `desc`，同时给 `<leader>a` / `<leader>c` / `<leader>e` / `<leader>s` / `<leader>sn` 配了分组名。改动键位时别漏掉同步描述和分组。
- `pi.nvim` 配在 `lua/plugins/pi.lua`，只做插件侧 `require("pi").setup()` 和快捷键绑定；真正执行依赖系统里的 `pi` CLI，不要把 CLI 安装逻辑写进仓库。
- `flash.nvim` 配在 `lua/plugins/flash.lua`，当前用 `s` 做普通跳转、`S` 做 Treesitter 跳转，并保留 `r` / `R` 这组更接近插件默认习惯的扩展键；以后如果要改跳转类键位，优先在这里统一调整。
- `fzf-lua` 配在 `lua/plugins/fzf.lua`，当前承担项目搜索入口，不要再额外假设仓库里有 Telescope；后续如果补搜索相关快捷键，优先沿用 `<leader>s*` 这组前缀并先检查 `noice` 的 `<leader>sn*` 子组。
- `fzf-lua` 依赖系统里的 `fzf`，而 `live_grep` 等内容搜索体验又强依赖 `rg`；这些外部命令要用户自己装，不要写安装逻辑进仓库。
- `nvim-treesitter` 配在 `lua/plugins/treesitter.lua`，使用新版 `require("nvim-treesitter").setup()` / `.install()` API，不是旧的 `nvim-treesitter.configs` 写法。
- `nvim-treesitter` 通过 `FileType` 自动命令按需 `vim.treesitter.start()`，并在存在 `indents` query 时给缓冲区设置 `indentexpr`。
- `nvim-treesitter` 的 parser 会按配置自动安装，但 `tree-sitter` CLI 及其系统依赖仍然要由用户在环境里手动准备；不要把 CLI 安装逻辑写进这个仓库。
- treesitter 折叠也在 `lua/plugins/treesitter.lua` 里处理：为已附着 parser 的窗口设置 `foldmethod=expr`、`foldexpr=v:lua.vim.treesitter.foldexpr()`，并把 `foldlevel` / `foldlevelstart` 设为 `99` 避免默认全折叠。
- `indent-blankline.nvim` 配在 `lua/plugins/indent_blankline.lua`，使用 `ibl` 入口和 `ibl.hooks` 注册高亮；彩色缩进线颜色取自 `catppuccin.palettes`，再和 `surface1` 混合成更淡的颜色。
- 现在仓库里已经装配 treesitter，所以 `indent-blankline.nvim` 已开启 `scope`；如果后续改动 treesitter 装配方式，记得一起检查 `ibl` 的 `scope` 是否还正常。

## 当前 LSP 面
- LSP 用的是 Neovim 内置 `vim.lsp.config()` / `vim.lsp.enable()`，不是 `nvim-lspconfig` 的旧写法。
- 语言服务器由用户在系统环境里自行安装；这个仓库只负责 Neovim 侧配置，不负责下载、管理或包裹 LSP 可执行文件。
- 因此各 LSP 模块里的 `cmd` 应直接写语言服务器本身的启动命令，不要在这里额外加安装逻辑、探测包装或下载脚本。
- 当前启用了四个语言服务器：`ty`、`lua_ls`、`rust_analyzer`、`rime_ls`。对应模块分别是 `lua/lsp/ty.lua`、`lua/lsp/lua_ls.lua`、`lua/lsp/rust_analyzer.lua`、`lua/lsp/rime_ls.lua`。
- 公共 LSP 快捷键也放在 `lua/lsp/init.lua`，通过 `LspAttach` 自动命令按 buffer 设置；新增通用 LSP 键位优先改这里，不要再塞回 `core`。
- `rime_ls` 在 `lua/lsp/rime_ls.lua` 里通过省略 `filetypes` 来达到“全部 filetype 都可 attach”；不要把它写成 `{ "*" }`，Neovim 会把那当成字面 filetype 导致根本不 attach。如果要改触发字符或切换策略，先看 `lua/lsp/init.lua` 里给 `rime_ls` 动态下发的 `trigger_characters`。
- 当前 `rime_ls` 的 `user_data_dir` 固定为 `~/.local/share/nvim/rime-ls`（即 `stdpath("data") .. "/rime-ls"`）；README 和 `lua/lsp/rime_ls.lua` 里的安装示例都假定把 `rime-ice` 直接装进这个目录，而不是再多包一层子目录。
- `rime_ls` 依赖系统里的 `rime_ls` / `rime-ls`、librime 和 rime-data；当前配置会优先读 `$RIME_DATA_DIR`，否则回退到 `/usr/share/rime-data`。
- 这些 LSP 模块都保持“编辑器侧通用配置”，项目专用规则应放语言自己的配置文件里，不要硬编码进这个仓库。
- `lua_ls` 额外把 `init.lua` 作为根标记，因为这个配置目录未必总有 `.git`。
- `rust-analyzer` 可能命中 `~/.cargo/bin/rust-analyzer -> rustup` 代理；只有安装了 `rustup component add rust-analyzer` 后这个命令才真正可用。

## 交互相关补充
- `K` 以及 `gd` / `gD` / `gi` / `gy` / `gr` / `<leader>ca` / `<leader>cr` / `[d` / `]d` 这些公共 LSP 键位都在 `lua/lsp/init.lua` 里配置。
- 其中 `gr` 当前不是直接调原生列表，而是优先走 `fzf-lua.lsp_references()`；如果 `fzf-lua` 不可用才回退到 `vim.lsp.buf.references()`。
- `rime_ls` 额外在 `lua/lsp/init.lua` 里挂了 `<leader>rr` / `<leader>rs`，用于切换输入和同步词库；这是特例型 LSP 键位，也仍然跟公共 LSP 键位放在一起维护。
- 当前 `K` 只调用原生 `vim.lsp.buf.hover`，具体弹窗样式交给 `noice.nvim` 处理；不要再在这个映射里塞一套独立浮窗样式，避免和 `noice` 重叠。

## 改动后检查
- 这里只有一个通用检查方式：`nvim --headless "+qa"`。它只能验证配置能否启动，不能替代交互式功能检查。
