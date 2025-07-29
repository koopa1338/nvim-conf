return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
      config = function()
        local swap = require "nvim-treesitter-textobjects.swap"
        Map("n", "<M-s>", function()
          swap.swap_next "@parameter.inner"
        end, { silent = true })
        Map("n", "<leader><M-s>", function()
          swap.swap_previous "@parameter.outer"
        end, { silent = true })
      end,
    },
  },
}
