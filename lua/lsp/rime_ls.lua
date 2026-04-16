if vim.g.rime_enabled == nil then
  vim.g.rime_enabled = true
end

local rime_cmd = vim.fn.executable("rime_ls") == 1 and "rime_ls" or "rime-ls"

-- rime-ls 的用户目录。
-- 如需安装 rime-ice，可直接把仓库内容放到这个目录，例如：
--   rm -rf ~/.local/share/nvim/rime-ls
--   git clone https://github.com/iDvel/rime-ice.git ~/.local/share/nvim/rime-ls --depth 1
-- 注意目标目录本身就是 user_data_dir，不要再多套一层 `rime-ice/` 子目录。
local rime_data_dir = vim.fn.stdpath("data") .. "/rime-ls"

vim.lsp.config("rime_ls", {
  cmd = { rime_cmd },
  workspace_required = false,
  init_options = {
    enabled = vim.g.rime_enabled,
    shared_data_dir = vim.env.RIME_DATA_DIR or "/usr/share/rime-data",
    user_data_dir = rime_data_dir,
    log_dir = rime_data_dir,
    max_candidates = 9,
    paging_characters = { ",", "." },
    trigger_characters = {},
    schema_trigger_character = "&",
    max_tokens = 0,
    always_incomplete = false,
    preselect_first = false,
    show_filter_text_in_label = false,
    long_filter_text = true,
  },
})

vim.lsp.enable("rime_ls")
