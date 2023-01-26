local M = { "folke/which-key.nvim", event = "VeryLazy" }

M.config = function()
  L("which-key", function(wk)
    wk.setup {
      plugins = {
        marks = false,
        registers = false,
      },
    }
  end)
end

return M
