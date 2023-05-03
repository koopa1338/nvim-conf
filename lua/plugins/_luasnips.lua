local M = {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      -- get friendly-snippets to work with LuaSnip
      L("luasnip.loaders.from_vscode").load()
      L("luasnip.loaders.from_lua").lazy_load()
    end,
  },
  event = "VeryLazy",
}

M.config = function()
  L("luasnip", function(ls)
    local signs = L("signs").signs
    local types = L "luasnip.util.types"
    ls.config.setup {
      history = true,
      delete_check_events = "TextChanged",
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { signs.SnipChoice.icon, signs.SnipChoice.hl } },
          },
        },
        [types.insertNode] = {
          active = {
            virt_text = { { signs.SnipInsert.icon, signs.SnipInsert.hl } },
          },
        },
      },
    }
    ls.filetype_extend("all", { "license" }) -- includes all license snippets
  end)
end

return M
