vim.pack.add({
  {
    src = "https://github.com/folke/noice.nvim",
  },
}, {
  load = true,
  confirm = false,
})

require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    lsp_doc_border = true,
  },
  views = {
    hover = {
      size = {
        max_width = math.floor(vim.o.columns * 0.6),
        max_height = math.floor(vim.o.lines * 0.3),
      },
    },
    cmdline_popup = {
      border = {
        style = "rounded",
      },
    },
    popupmenu = {
      border = {
        style = "rounded",
      },
    },
  },
})

vim.keymap.set("n", "<leader>snh", function()
  require("noice").cmd("history")
end, { desc = "打开消息历史('snh' for 'Search Noice History')" })

vim.keymap.set("n", "<leader>snl", function()
  require("noice").cmd("last")
end, { desc = "打开最近一条消息('snl' for 'Search Noice Last')" })

vim.keymap.set("n", "<leader>snd", function()
  require("noice").cmd("dismiss")
end, { desc = "清除当前消息('snd' for 'Search Noice Dismiss')" })
