return {
  "L3MON4D3/LuaSnip",
  config = function()
    require("luasnip.config").setup({ enable_autosnippets = true })

    -- 将 snipper 文件夹添加到 runtimepath
    vim.opt.runtimepath:append(vim.fn.stdpath("config") .. "/my-snippets")
    -- snippets/<ft>.snippets and snippets/<ft>/*.snippets
    require("luasnip.loaders.from_snipmate").lazy_load()
    -- luasnippets/<ft>.snippets and luasnippets/<ft>/*.snippets
    require("luasnip.loaders.from_lua").lazy_load()
  end
}

