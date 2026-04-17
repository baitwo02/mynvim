vim.pack.add({
  {
    src = "https://github.com/echasnovski/mini.nvim",
  },
}, {
  load = true,
  confirm = false,
})

local statusline = require("mini.statusline")
local files = require("mini.files")

statusline.setup({
  use_icons = vim.g.have_nerd_font == true,
})

statusline.section_location = function()
  return "%2l:%-2v"
end

files.setup({})

local function get_current_buffer_path()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    return nil
  end

  return path
end

local function toggle_mini_files(path)
  if not MiniFiles.close() then
    MiniFiles.open(path, false)
  end
end

vim.keymap.set("n", "<leader>ee", function()
  toggle_mini_files(get_current_buffer_path() or vim.fn.getcwd())
end, {
  desc = "打开文件浏览器('ee' for 'Explorer here')",
})

vim.keymap.set("n", "<leader>ec", function()
  toggle_mini_files(vim.fn.getcwd())
end, {
  desc = "打开当前工作目录('ec' for 'Explorer Cwd')",
})

vim.keymap.set("n", "<leader>ef", function()
  toggle_mini_files(get_current_buffer_path() or vim.fn.getcwd())
end, {
  desc = "打开当前文件位置('ef' for 'Explorer File')",
})
