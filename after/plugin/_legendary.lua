L("legendary", function(legendary)
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
        a = { "Autocmds" },
        c = { "Commands" },
        f = { "Functions" },
        k = { "Keymaps" },
        s = { "All" },
      },
    }, { prefix = "<leader>" })
  end)
end)
