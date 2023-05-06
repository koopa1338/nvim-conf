local M = {
  "folke/trouble.nvim",
  dependencies = "kyazdani42/nvim-web-devicons",
  cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
}

M.config = function()
  L("trouble", function(trouble)
    trouble.setup {
      auto_preview = false,
      auto_fold = false,
      auto_close = true,
      use_diagnostic_signs = true,
      height = 15,
      padding = false,
      fold_open = Get_sign_def("FoldOpen").icon,
      fold_closed = Get_sign_def("FoldClosed").icon,
      action_keys = {
        jump = "o",
        jump_close = { "<cr>", "<tab>" },
      },
    }

    Map("n", "<leader>Tt", "<cmd>Trouble<CR>", { silent = true, desc = "Show document diagnostics" })
    Map(
      "n",
      "<leader>TT",
      "<cmd>Trouble document_diagnostics<CR>",
      { silent = true, desc = "Show workspace diagnostics" }
    )
    Map("n", "<leader>Tr", "<cmd>TroubleRefresh<CR>", { silent = true, desc = "Refresh diagnostic window" })

    L("which-key", function(wk)
      wk.register({
        T = {
          name = "+Diagnostics",
          t = { "Show document diagnostics" },
          T = { "Show workspace diagnostics" },
          r = { "Refresh diagnostic window" },
        },
      }, { prefix = "<leader>" })
    end)
  end)
end

return M
