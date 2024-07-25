return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  build = function() require 'typst-preview'.update() end,
  config = function()
    require 'typst-preview'.setup {
      -- 设置为 true 将启用使用 print() 打印调试信息
      debug = false,

      -- 自定义格式字符串以打开输出链接，使用 %s 表示链接
      -- 示例: open_cmd = 'firefox %s -P typst-preview --class typst-preview'
      open_cmd = 'firefox %s -P typst-preview --class typst-preview',

      -- 设置为 'always' 将在预览中反转黑白颜色
      -- 设置为 'auto' 将根据浏览器是否启用暗模式来决定是否反转
      invert_colors = 'never',

      -- 预览是否跟随源文件中的光标
      follow_cursor = true,

      -- 提供依赖项二进制文件的路径。
      -- 设置此项将跳过插件下载二进制文件。
      -- 警告: 请注意，您使用的版本可能比所需版本旧。
      dependencies_bin = {
        -- 如果您使用的是 tinymist，只需设置 ['typst-preview'] = "tinymist"。
        -- ['typst-preview'] = nil,
        ['typst-preview'] = "tinymist",
        ['websocat'] = nil
      },

      -- 此函数将用于确定 typst 项目的根目录
      get_root = function(path_of_main_file)
        return vim.fn.fnamemodify(path_of_main_file, ':p:h')
      end,

      -- 此函数将用于确定 typst 项目的主文件
      get_main_file = function(path_of_buffer)
        return path_of_buffer
      end,
    }
  end
}

