local M = {
  "echasnovski/mini.nvim",
  event = "VimEnter",
}

M.config = function()
  L("mini.pairs", function(mp)
    mp.setup()
  end)

  L("mini.ai", function(ai)
    local spec_treesitter = ai.gen_spec.treesitter
    ai.setup {
      custom_textobjects = {
        f = spec_treesitter { a = "@function.outer", i = "@function.inner" },
        c = spec_treesitter { a = "@class.outer", i = "@class.inner" },
        s = spec_treesitter { a = "@block.outer", i = "@block.inner" },
      },
      n_lines = 500,
      search_method = "cover",
      silent = true,
    }
  end)

  L("mini.surround", function(surround)
    surround.setup {
      mappings = {
        add = "ysa",
        delete = "ysd",
        find = "ysf",
        find_left = "ysF",
        highlight = "ysh",
        replace = "ysr",
        update_n_lines = "ysn",
        suffix_last = "l",
        suffix_next = "n",
      },
      n_lines = 500,
    }
  end)

  L("mini.bracketed", function(bracketed)
    bracketed.setup()
  end)

  L("mini.statusline", function(sl)
    sl.setup()
  end)
end

return M
