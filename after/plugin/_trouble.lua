L("trouble", function(trouble)
  trouble.setup {
    auto_preview = false,
    auto_fold = true,
    auto_close = true,
    use_diagnostic_signs = true,
    height = 15,
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
