L("urlview", function(urlview)
  urlview.setup {
    default_action = "system",
  }

  Map("n", "<leader>uu", ":UrlView<CR>", { silent = true })
  Map("n", "<leader>uf", function()
    vim.ui.input({ prompt = "File path: " }, function(input)
      urlview.search("file", { filepath = input })
    end)
  end, { silent = true })
  Map("n", "<leader>uj", ":UrlView jira<CR>", { silent = true })
  Map("n", "<leader>up", ":UrlView packer<CR>", { silent = true })

  L("which-key", function(wk)
    wk.register({
      u = {
        name = "+urlview",
        f = { "Show URLs of File" },
        j = { "Show Jira URLs" },
        p = { "Show Packer URLs" },
        u = { "Show local URLs" },
      },
    }, { prefix = "<leader>" })
  end)
end)
