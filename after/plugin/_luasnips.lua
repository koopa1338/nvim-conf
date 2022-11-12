L("luasnip", function(ls)
  ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  }

  -- get friendly-snippets to work with LuaSnip
  require("luasnip.loaders.from_vscode").lazy_load()
end)
