L("trouble", function(trouble)
  trouble.setup {
    auto_preview = false,
    auto_fold = true,
    auto_close = true,
    use_diagnostic_signs = true,
    height = 15,
  }

  Map("n", "<leader>dd", ":Trouble<CR>", { silent = true })
  Map("n", "<leader>db", ":Trouble document_diagnostics<CR>", { silent = true })
  Map("n", "<leader>dq", ":Trouble quickfix<CR>", { silent = true })
  Map("n", "<leader>dl", ":Trouble loclist<CR>", { silent = true })
  Map("n", "<leader>dr", ":TroubleRefresh<CR>", { silent = true })

  L("which-key", function(wk)
    wk.register({
      D = {
        name = "+Diagnostics",
        b = { "Show document diagnostics" },
        d = { "Show workspace diagnostics" },
        l = { "Show location list (Trouble)" },
        q = { "Show quickfix (Trouble)" },
        r = { "Refresh diagnostic window" },
      },
    }, { prefix = "<leader>" })
  end)
end)
