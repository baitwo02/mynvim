return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
        flavour = "auto", -- 自动选择口味：latte, frappe, macchiato, mocha
        background = { -- 背景颜色
            light = "latte", -- 浅色背景
            dark = "mocha", -- 深色背景
        },
        transparent_background = true, -- 禁用设置背景颜色
        show_end_of_buffer = false, -- 不显示缓冲区末尾的 '~' 字符
        term_colors = false, -- 设置终端颜色（例如 `g:terminal_color_0`）
        dim_inactive = {
            enabled = false, -- 禁用非活动窗口的背景颜色变暗
            shade = "dark", -- 变暗的色调
            percentage = 0.15, -- 应用于非活动窗口的变暗百分比
        },
        no_italic = false, -- 强制不使用斜体
        no_bold = false, -- 强制不使用粗体
        no_underline = false, -- 强制不使用下划线
        styles = { -- 处理一般高亮组的样式（参见 `:h highlight-args`）：
            comments = { "italic" }, -- 更改注释的样式
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
            -- miscs = {}, -- 取消注释以关闭硬编码的样式
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            notify = false,
            mini = {
                enabled = true,
                indentscope_color = "",
            },
            -- 更多插件集成请参见（https://github.com/catppuccin/nvim#integrations）
        },
    })

    -- 必须在加载之前调用 setup
    vim.cmd.colorscheme "catppuccin"
  end
}

