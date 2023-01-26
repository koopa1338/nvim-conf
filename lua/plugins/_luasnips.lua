local M = {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
}

M.config = function()
  L("luasnip", function(ls)
    ls.config.set_config {
      history = true,
      updateevents = "TextChanged,TextChangedI",
    }

    -- get friendly-snippets to work with LuaSnip
    L("luasnip.loaders.from_vscode").lazy_load()

    -- some shorthands...
    local snip = ls.snippet
    local node = ls.snippet_node
    local text = ls.text_node
    local insert = ls.insert_node
    local func = ls.function_node
    local choice = ls.choice_node
    local dynamicn = ls.dynamic_node

    ls.add_snippets(nil, {
      rust = {
        snip({
          trig = "tmod",
          namr = "test mod",
          dscr = "create mod for tests",
        }, {
          text "#[cfg(test)]",
          text { "", "mod test {" },
          text { "", "\tuse super::*;" },
          text { "", "" },
          text { "", "\t" },
          insert(0),
          text { "", "}" },
        }),
      },
      python = {
        snip("pybang", {
          text { "#!/usr/bin/env python", "" },
          insert(0),
        }),
      },
    })
  end)
end

return M
