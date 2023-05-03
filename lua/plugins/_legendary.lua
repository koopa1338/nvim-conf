local M = {
  "mrjones2014/legendary.nvim",
  dependencies = {
    "folke/which-key.nvim",
  },
  cmd = "Legendary",
  cond = vim.g.whichkey,
}

M.config = function()
  L("legendary", function(legendary)
    -- this has to run before any which-key register events.
    legendary.setup()

    Map("n", "<leader>sa", ":Legendary autocmds<CR>", { silent = true })
    Map("n", "<leader>sc", ":Legendary commands<CR>", { silent = true })
    Map("n", "<leader>sf", ":Legendary functions<CR>", { silent = true })
    Map("n", "<leader>sk", ":Legendary keymaps<CR>", { silent = true })
    Map("n", "<leader>ss", ":Legendary<CR>", { silent = true })

    L("which-key", function(wk)
      wk.register({
        s = {
          name = "+search",
          a = { "Search Autocmds" },
          c = { "Search Commands" },
          f = { "Search Functions" },
          k = { "Search Keymaps" },
          s = { "Search All" },
        },
      }, { prefix = "<leader>" })
    end)
  end)
end
return M
