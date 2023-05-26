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
  event = "InsertEnter",
  build = "make install_jsregexp",
}

M.config = function()
  L("luasnip", function(ls)
    local signs = L("signs").signs
    local types = L "luasnip.util.types"
    local extras = L "luasnip.extras"
    local fmt_mod = L "luasnip.extras.fmt"
    ---@diagnostic disable: need-check-nil
    ls.config.setup {
      history = true,
      delete_check_events = "TextChanged",
      -- globals that can be used in snippets under luasnippets/
      snip_env = {
        ls = ls,
        s = ls.snippet,
        sn = ls.snippet_node,
        isn = ls.indent_snippet_node,
        t = ls.text_node,
        i = ls.insert_node,
        f = ls.function_node,
        c = ls.choice_node,
        d = ls.dynamic_node,
        r = ls.restore_node,
        events = L "luasnip.util.events",
        ai = L "luasnip.nodes.absolute_indexer",
        extras = extras,
        l = extras.lambda,
        rep = extras.rep,
        p = extras.partial,
        m = extras.match,
        n = extras.nonempty,
        dl = extras.dynamic_lambda,
        fmt = fmt_mod.fmt,
        fmta = fmt_mod.fmta,
        conds = L "luasnip.extras.expand_conditions",
        postfix = L("luasnip.extras.postfix").postfix,
        types = L "luasnip.util.types",
        parse = L("luasnip.util.parser").parse_snippet,
        ms = ls.multi_snippet,
      },
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
