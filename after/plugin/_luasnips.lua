L("luasnip", function(ls)
  ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  }
  -- toggle choices of choice nodes
  Map("i", "<C-k>", require "luasnip.extras.select_choice", { silent = true })

  -- get friendly-snippets to work with LuaSnip
  require("luasnip.loaders.from_vscode").lazy_load()
end)
