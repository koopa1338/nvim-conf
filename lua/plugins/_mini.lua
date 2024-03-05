local M = {
  "echasnovski/mini.nvim",
  event = "VimEnter",
}

M.config = function()
  L("mini.pairs", function(mp)
    mp.setup()
  end)

  L("mini.surround", function(surround)
    surround.setup()
  end)

  L("mini.ai", function(ai)
    ai.setup {
      custom_textobjects = {
        f = false,
      },
      n_lines = 500,
      silent = true,
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
