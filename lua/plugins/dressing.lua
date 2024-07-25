return {
  [[stevearc/dressing.nvim]],
  opts = {},

  config = function ()
    require("dressing").setup({
      input = {
        -- 设置为 false 以禁用 vim.ui.input 实现
        enabled = true,

        -- 默认提示字符串
        default_prompt = "输入",

        -- 修剪提示末尾的 `:`
        trim_prompt = true,

        -- 可以是 'left', 'right', 或 'center'
        title_pos = "left",

        -- 当为 true 时，输入将开始于插入模式
        start_in_insert = true,

        -- 这些参数会传递给 nvim_open_win
        border = "rounded",
        -- 'editor' 和 'win' 将默认居中
        relative = "cursor",

        -- 这些可以是整数或 0 到 1 之间的浮点数（例如 0.4 表示 40%）
        prefer_width = 40,
        width = nil,
        -- min_width 和 max_width 可以是混合类型的列表。
        -- min_width = {20, 0.2} 表示 "20 列或总宽度的 20% 中较大者"
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },

        buf_options = {},
        win_options = {
          -- 禁用行换行
          wrap = false,
          -- 当文本超出窗口时的指示器
          list = true,
          listchars = "precedes:…,extends:…",
          -- 增加此值以获得更多上下文，当文本滚动出窗口时
          sidescrolloff = 0,
        },

        -- 设置为 `false` 以禁用
        mappings = {
          n = {
            ["<Esc>"] = "关闭",
            ["<CR>"] = "确认",
          },
          i = {
            ["<C-c>"] = "关闭",
            ["<CR>"] = "确认",
            ["<Up>"] = "历史前一项",
            ["<Down>"] = "历史后一项",
          },
        },

        override = function(conf)
          -- 这是传递给 nvim_open_win 的配置。
          -- 更改这里的值以自定义布局
          return conf
        end,

        -- 查看 :help dressing_get_config
        get_config = nil,
      },
      select = {
        -- 设置为 false 以禁用 vim.ui.select 实现
        enabled = true,

        -- 首选的 vim.select 实现优先级列表
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

        -- 修剪提示末尾的 `:`
        trim_prompt = true,

        -- telescope 选择器的选项
        -- 这些选项会直接传递给 telescope 选择器。可以使用如下方式：
        -- telescope = require('telescope.themes').get_ivy({...})
        telescope = nil,

        -- fzf 选择器的选项
        fzf = {
          window = {
            width = 0.5,
            height = 0.4,
          },
        },

        -- fzf-lua 选择器的选项
        fzf_lua = {
          -- winopts = {
          --   height = 0.5,
          --   width = 0.5,
          -- },
        },

        -- nui Menu 的选项
        nui = {
          position = "50%",
          size = nil,
          relative = "editor",
          border = {
            style = "rounded",
          },
          buf_options = {
            swapfile = false,
            filetype = "DressingSelect",
          },
          win_options = {
            winblend = 0,
          },
          max_width = 80,
          max_height = 40,
          min_width = 40,
          min_height = 10,
        },

        -- 内置选择器的选项
        builtin = {
          -- 显示选项编号并设置键映射
          show_numbers = true,
          -- 这些参数会传递给 nvim_open_win
          border = "rounded",
          -- 'editor' 和 'win' 将默认居中
          relative = "editor",

          buf_options = {},
          win_options = {
            cursorline = true,
            cursorlineopt = "both",
          },

          -- 这些可以是整数或 0 到 1 之间的浮点数（例如 0.4 表示 40%）
          -- min_ 和 max_ 选项可以是混合类型的列表。
          -- max_width = {140, 0.8} 表示 "140 列或总宽度的 80% 中较小者"
          width = nil,
          max_width = { 140, 0.8 },
          min_width = { 40, 0.2 },
          height = nil,
          max_height = 0.9,
          min_height = { 10, 0.2 },

          -- 设置为 `false` 以禁用
          mappings = {
            ["<Esc>"] = "关闭",
            ["<C-c>"] = "关闭",
            ["<CR>"] = "确认",
          },

          override = function(conf)
            -- 这是传递给 nvim_open_win 的配置。
            -- 更改这里的值以自定义布局
            return conf
          end,
        },

        -- 用于覆盖 format_item。查看 :help dressing-format
        format_item_override = {},

        -- 查看 :help dressing_get_config
        get_config = nil,
      },
    })
  end
}
