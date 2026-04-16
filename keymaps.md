# Keymaps

这份文档只整理**当前仓库里显式配置过的快捷键**，方便查看用途与潜在冲突。

说明：
- `<leader>` 是空格。
- `K` 是在 LSP attach 到当前缓冲区后才会设置。
- `blink.cmp` 那组键主要在**插入模式 / 补全菜单可见时**生效。
- `which-key.nvim` 会根据各映射的 `desc` 显示提示，但它本身不额外占用这里列出的键位。

---

## 一览：按功能分类

### 基础编辑与诊断

| 模式 | 快捷键 | 功能 | 来源 |
|---|---|---|---|
| `n` | `<Esc>` | 清除搜索高亮 | `lua/core/keymaps.lua` |
| `n` | `<leader>q` | 打开诊断位置列表 | `lua/core/keymaps.lua` |
| `n,v` | `gh` | 移动到行首 | `lua/core/keymaps.lua` |
| `n,v` | `gl` | 移动到行尾最后一个非空字符 | `lua/core/keymaps.lua` |

### 跳转 / flash.nvim

| 模式 | 快捷键 | 功能 | 来源 |
|---|---|---|---|
| `n,x,o` | `s` | Flash 普通跳转 | `lua/plugins/flash.lua` |
| `n,x,o` | `S` | Flash Treesitter 跳转 | `lua/plugins/flash.lua` |
| `o` | `r` | Flash 远程操作 | `lua/plugins/flash.lua` |
| `x,o` | `R` | Flash Treesitter 搜索 | `lua/plugins/flash.lua` |

### LSP

| 模式 | 快捷键 | 功能 | 来源 |
|---|---|---|---|
| `n` | `K` | 显示 hover 文档 | `lua/lsp/init.lua` |
| `n` | `gd` | 跳到定义 | `lua/lsp/init.lua` |
| `n` | `gD` | 跳到声明 | `lua/lsp/init.lua` |
| `n` | `gi` | 跳到实现 | `lua/lsp/init.lua` |
| `n` | `gy` | 跳到类型定义 | `lua/lsp/init.lua` |
| `n` | `gr` | 通过 fzf-lua 列表查看引用 | `lua/lsp/init.lua` |
| `n` | `[d` | 跳到上一条诊断 | `lua/lsp/init.lua` |
| `n` | `]d` | 跳到下一条诊断 | `lua/lsp/init.lua` |
| `n,x` | `<leader>ca` | 代码操作 | `lua/lsp/init.lua` |
| `n` | `<leader>cr` | 重命名符号 | `lua/lsp/init.lua` |
| `n` | `<leader>rr` | 切换 Rime 输入开关 | `lua/lsp/init.lua` |
| `n` | `<leader>rs` | 同步 Rime 用户数据 | `lua/lsp/init.lua` |

### 窗口与终端

| 模式 | 快捷键 | 功能 | 来源 |
|---|---|---|---|
| `n` | `<C-h>` | 焦点移到左侧窗口 | `lua/core/keymaps.lua` |
| `n` | `<C-j>` | 焦点移到下方窗口 | `lua/core/keymaps.lua` |
| `n` | `<C-k>` | 焦点移到上方窗口 | `lua/core/keymaps.lua` |
| `n` | `<C-l>` | 焦点移到右侧窗口 | `lua/core/keymaps.lua` |
| `t` | `<Esc><Esc>` | 退出终端插入模式 | `lua/core/keymaps.lua` |

### AI / pi.nvim

| 模式 | 快捷键 | 功能 | 来源 |
|---|---|---|---|
| `n` | `<leader>ai` | 用当前缓冲区上下文询问 pi | `lua/plugins/pi.lua` |
| `v` | `<leader>ai` | 用当前选中内容询问 pi | `lua/plugins/pi.lua` |
| `n` | `<leader>ac` | 取消当前 pi 请求 | `lua/plugins/pi.lua` |
| `n` | `<leader>al` | 打开 pi 日志 | `lua/plugins/pi.lua` |

### 搜索 / fzf-lua

| 模式 | 快捷键 | 功能 | 来源 |
|---|---|---|---|
| `n` | `<leader>ss` | 打开全局搜索入口 | `lua/plugins/fzf.lua` |
| `n` | `<leader>sf` | 搜索文件 | `lua/plugins/fzf.lua` |
| `n` | `<leader>sg` | 搜索项目内容 | `lua/plugins/fzf.lua` |
| `n` | `<leader>sw` | 搜索光标下单词 | `lua/plugins/fzf.lua` |
| `n` | `<leader>sb` | 搜索缓冲区 | `lua/plugins/fzf.lua` |
| `n` | `<leader>sh` | 搜索帮助文档 | `lua/plugins/fzf.lua` |
| `n` | `<leader>sr` | 恢复上次搜索 | `lua/plugins/fzf.lua` |

### 消息与弹窗 UI / noice.nvim

| 模式 | 快捷键 | 功能 | 来源 |
|---|---|---|---|
| `n` | `<leader>snh` | 打开 Noice 消息历史 | `lua/plugins/noice.lua` |
| `n` | `<leader>snl` | 打开最近一条 Noice 消息 | `lua/plugins/noice.lua` |
| `n` | `<leader>snd` | 清除当前 Noice 消息 | `lua/plugins/noice.lua` |

### 补全 / blink.cmp

| 模式 | 快捷键 | 功能 | 来源 |
|---|---|---|---|
| `i` | `<C-space>` | 打开补全菜单 / 显示或隐藏文档 | `lua/plugins/blink.lua` |
| `i` | `<C-e>` | 关闭补全菜单，否则 fallback | `lua/plugins/blink.lua` |
| `i` | `<CR>` | 接受当前补全项，否则 fallback | `lua/plugins/blink.lua` |
| `i` | `<C-b>` | 向上滚动补全文档 | `lua/plugins/blink.lua` |
| `i` | `<C-f>` | 向下滚动补全文档 | `lua/plugins/blink.lua` |
| `i` | `<C-j>` | 跳到下一个 snippet 占位，否则 fallback | `lua/plugins/blink.lua` |
| `i` | `<C-k>` | 跳到上一个 snippet 占位，否则 fallback | `lua/plugins/blink.lua` |
| `i` | `<Tab>` | 选择下一个候选，否则 fallback | `lua/plugins/blink.lua` |
| `i` | `<S-Tab>` | 选择上一个候选，否则 fallback | `lua/plugins/blink.lua` |
| `i` | `<A-1>` | 接受第 1 个候选 | `lua/plugins/blink.lua` |
| `i` | `<A-2>` | 接受第 2 个候选 | `lua/plugins/blink.lua` |
| `i` | `<A-3>` | 接受第 3 个候选 | `lua/plugins/blink.lua` |
| `i` | `<A-4>` | 接受第 4 个候选 | `lua/plugins/blink.lua` |
| `i` | `<A-5>` | 接受第 5 个候选 | `lua/plugins/blink.lua` |
| `i` | `<A-6>` | 接受第 6 个候选 | `lua/plugins/blink.lua` |
| `i` | `<A-7>` | 接受第 7 个候选 | `lua/plugins/blink.lua` |
| `i` | `<A-8>` | 接受第 8 个候选 | `lua/plugins/blink.lua` |
| `i` | `<A-9>` | 接受第 9 个候选 | `lua/plugins/blink.lua` |
| `i` | `<A-0>` | 接受第 10 个候选 | `lua/plugins/blink.lua` |

---

## 一览：按插件 / 模块分类

### `lua/core/keymaps.lua`

| 模式 | 快捷键 | 功能 |
|---|---|---|
| `n` | `<Esc>` | 清除搜索高亮 |
| `n` | `<leader>q` | 打开诊断位置列表 |
| `t` | `<Esc><Esc>` | 退出终端插入模式 |
| `n` | `<C-h>` | 焦点移到左侧窗口 |
| `n` | `<C-j>` | 焦点移到下方窗口 |
| `n` | `<C-k>` | 焦点移到上方窗口 |
| `n` | `<C-l>` | 焦点移到右侧窗口 |
| `n,v` | `gh` | 移动到行首 |
| `n,v` | `gl` | 移动到行尾最后一个非空字符 |

### `lua/plugins/flash.lua`

| 模式 | 快捷键 | 功能 |
|---|---|---|
| `n,x,o` | `s` | Flash 普通跳转 |
| `n,x,o` | `S` | Flash Treesitter 跳转 |
| `o` | `r` | Flash 远程操作 |
| `x,o` | `R` | Flash Treesitter 搜索 |

### `lua/lsp/init.lua`

| 模式 | 快捷键 | 功能 | 条件 |
|---|---|---|---|
| `n` | `K` | 显示 hover 文档 | 仅 LSP attach 后 |
| `n` | `gd` | 跳到定义 | 仅 LSP attach 后且服务器支持 |
| `n` | `gD` | 跳到声明 | 仅 LSP attach 后且服务器支持 |
| `n` | `gi` | 跳到实现 | 仅 LSP attach 后且服务器支持 |
| `n` | `gy` | 跳到类型定义 | 仅 LSP attach 后且服务器支持 |
| `n` | `gr` | 通过 fzf-lua 列表查看引用 | 仅 LSP attach 后且服务器支持 |
| `n` | `[d` | 跳到上一条诊断 | 仅 LSP attach 后 |
| `n` | `]d` | 跳到下一条诊断 | 仅 LSP attach 后 |
| `n,x` | `<leader>ca` | 代码操作 | 仅 LSP attach 后且服务器支持 |
| `n` | `<leader>cr` | 重命名符号 | 仅 LSP attach 后且服务器支持 |
| `n` | `<leader>rr` | 切换 Rime 输入开关 | 仅 rime_ls attach 后 |
| `n` | `<leader>rs` | 同步 Rime 用户数据 | 仅 rime_ls attach 后 |

### `lua/plugins/pi.lua`

| 模式 | 快捷键 | 功能 |
|---|---|---|
| `n` | `<leader>ai` | 用当前缓冲区上下文询问 pi |
| `v` | `<leader>ai` | 用当前选中内容询问 pi |
| `n` | `<leader>ac` | 取消当前 pi 请求 |
| `n` | `<leader>al` | 打开 pi 日志 |

### `lua/plugins/fzf.lua`

| 模式 | 快捷键 | 功能 |
|---|---|---|
| `n` | `<leader>ss` | 打开全局搜索入口 |
| `n` | `<leader>sf` | 搜索文件 |
| `n` | `<leader>sg` | 搜索项目内容 |
| `n` | `<leader>sw` | 搜索光标下单词 |
| `n` | `<leader>sb` | 搜索缓冲区 |
| `n` | `<leader>sh` | 搜索帮助文档 |
| `n` | `<leader>sr` | 恢复上次搜索 |

### `lua/plugins/noice.lua`

| 模式 | 快捷键 | 功能 |
|---|---|---|
| `n` | `<leader>snh` | 打开 Noice 消息历史 |
| `n` | `<leader>snl` | 打开最近一条 Noice 消息 |
| `n` | `<leader>snd` | 清除当前 Noice 消息 |

### `lua/plugins/blink.lua`

| 模式 | 快捷键 | 功能 |
|---|---|---|
| `i` | `<C-space>` | 打开补全菜单 / 显示或隐藏文档 |
| `i` | `<C-e>` | 关闭补全菜单，否则 fallback |
| `i` | `<CR>` | 接受当前补全项，否则 fallback |
| `i` | `<C-b>` | 向上滚动补全文档 |
| `i` | `<C-f>` | 向下滚动补全文档 |
| `i` | `<C-j>` | 跳到下一个 snippet 占位，否则 fallback |
| `i` | `<C-k>` | 跳到上一个 snippet 占位，否则 fallback |
| `i` | `<Tab>` | 选择下一个候选，否则 fallback |
| `i` | `<S-Tab>` | 选择上一个候选，否则 fallback |
| `i` | `<A-1>` ~ `<A-9>` | 直接接受第 1 ~ 9 个候选 |
| `i` | `<A-0>` | 直接接受第 10 个候选 |

---

## 潜在冲突检查

下面这些键位目前**不一定真冲突**，但值得在以后加新映射时优先检查。

### 1. `<C-j>` / `<C-k>`

- 普通模式：用于窗口切换
- 插入模式的补全场景：用于 snippet 前后跳

当前状态：
- **不构成直接冲突**，因为模式不同
- 但如果后面再给插入模式单独绑定 `<C-j>` / `<C-k>`，就要和 `blink.cmp` 协调

### 2. `<Tab>` / `<S-Tab>`

- 目前在 `blink.cmp` 里用于候选切换

当前状态：
- 如果以后要给 `<Tab>` 做自动补全缩进、snippet 扩展、括号跳转之类逻辑，要先检查和 `blink.cmp` 的 fallback 行为是否符合预期

### 3. `<A-0>` ~ `<A-9>`

- 目前在 `blink.cmp` 里用于按序号上屏

当前状态：
- 最大风险不是映射冲突，而是**终端是否真的能发出这些 Alt 组合键**
- 如果某个终端 / tmux 下不生效，先怀疑终端转义和按键传递，不要先怀疑 Neovim 配置

### 4. `s` / `S`

- 当前这两个键已经交给 `flash.nvim`
  - `s`：普通跳转
  - `S`：Treesitter 跳转

当前状态：
- 这会覆盖原生的 `s`（substitute）和 `S`（整行 substitute）行为
- 原生 `x` 已经保留下来，不再被 `flash.nvim` 占用
- 如果后续还想把这组键改给别的跳转插件，优先改 `lua/plugins/flash.lua`

### 5. `K`

- 当前由 `lua/lsp/init.lua` 里的 `LspAttach` 自动命令在 buffer 上设置为 `vim.lsp.buf.hover`

当前状态：
- 会覆盖默认的 `K`（通常是 `keywordprg`）
- 如果以后某个文件类型插件也想占用 `K`，要检查谁后设置、是否 buffer-local、是否需要条件判断

### 6. `gd` / `gD` / `gi` / `gy` / `gr`

- 当前都属于公共 LSP 键位，按 buffer 设置

当前状态：
- 这些键只有在 LSP attach 后才会出现
- `gr` 现在已经走 `fzf-lua` 列表式 UI；如果以后想改回原生 `vim.lsp.buf.references()`，优先改 `lua/lsp/init.lua`
- `gy` 当前用于类型定义，后续如果你更偏好别的传统位段，也应统一在 `lua/lsp/init.lua` 调整

### 7. `<leader>a*`

- 当前已经被 `pi.nvim` 占用：
  - `<leader>ai`
  - `<leader>ac`
  - `<leader>al`

建议：
- 以后新增 AI 相关快捷键，优先继续放到 `<leader>a` 组下
- 避免把无关功能也塞进这个前缀

### 8. `<leader>r*`

- 当前已经被 `rime_ls` 占用：
  - `<leader>rr`
  - `<leader>rs`

建议：
- 后续继续新增 Rime 相关快捷键时，优先沿用 `<leader>r*`
- 避免把与输入法无关的功能塞进这个前缀

### 9. `<leader>s*`

- 当前已经形成一整个搜索 / 消息前缀组：
  - `fzf-lua`
    - `<leader>ss`
    - `<leader>sf`
    - `<leader>sg`
    - `<leader>sw`
    - `<leader>sb`
    - `<leader>sh`
    - `<leader>sr`
  - `noice.nvim`
    - `<leader>snh`
    - `<leader>snl`
    - `<leader>snd`

建议：
- 后续继续新增搜索相关快捷键时，优先沿用 `<leader>s*`
- 但要注意 `noice` 已经占用了 `<leader>sn*` 这组子前缀，不要和新的搜索键重复

### 10. `<leader>q`

- 当前固定用于诊断位置列表

建议：
- 如果以后想把 quickfix/location list 分开配置，可以再考虑是否保留这个入口，还是拆成更细的前缀

### 11. `<Esc><Esc>`

- 当前终端模式下退出终端插入模式

当前状态：
- 在部分终端 / tmux 环境里，双 Esc 可能有兼容性问题
- 如果以后有别的终端模式映射不生效，先排查终端层行为

---

## 当前前缀占用概览

### `<leader>`

| 前缀 | 当前用途 |
|---|---|
| `<leader>q` | 诊断位置列表 |
| `<leader>a` | pi / AI 相关 |
| `<leader>c` | LSP 代码操作 / 重命名 |
| `<leader>r` | Rime 相关 |
| `<leader>s` | fzf-lua 搜索主入口 |
| `<leader>sn` | Noice 消息与通知相关 |

### 其他常见单键 / 组合键

| 键 | 当前用途 |
|---|---|
| `s` / `S` | Flash 跳转 |
| `x` | 保留原生删除字符用途 |
| `K` | LSP hover |
| `gd/gD/gi/gy` | LSP 跳转 |
| `gr` | LSP 引用列表（fzf-lua） |
| `[d` / `]d` | LSP 诊断跳转 |
| `<leader>rr` / `<leader>rs` | Rime 切换 / 同步 |
| `gh` | 行首 |
| `gl` | 行尾 |
| `<C-h/j/k/l>` | 窗口切换 |
| `<Tab>` / `<S-Tab>` | blink 候选切换 |
| `<A-0..9>` | blink 按序号上屏 |
| `<leader>c*` | LSP 代码操作相关 |
| `<leader>s*` | fzf-lua / noice 搜索与消息相关 |

---

## 目前未显式自定义、后续可用的常见 LSP 键位位段

当前仓库已经显式配置了这批常见 LSP 快捷键：

- `gd`
- `gD`
- `gr`
- `gi`
- `gy`
- `[d` / `]d`
- `<leader>ca`
- `<leader>cr`

后续如果继续补 LSP 键位，建议优先继续沿用这些传统位段，并统一在 `lua/lsp/init.lua` 里维护。
