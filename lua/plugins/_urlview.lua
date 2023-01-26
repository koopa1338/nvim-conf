local M = { "axieax/urlview.nvim", event = "VeryLazy" }

M.config = function()
  L("urlview", function(urlview)
    urlview.setup {
      default_action = "system",
      picker = "telescope",
    }

    Map("n", "<leader>uu", "<cmd>UrlView<CR>", { silent = true, desc = "Show local URLs" })
    Map("n", "<leader>uf", function()
      vim.ui.input({ prompt = "File path: " }, function(input)
        urlview.search("file", { filepath = input })
      end)
    end, { silent = true, desc = "Show URLs of File" })
    Map("n", "<leader>uj", "<cmd>UrlView jira<CR>", { silent = true, desc = "Show Jira URLs" })
    Map("n", "<leader>up", "<cmd>UrlView packer<CR>", { silent = true, desc = "Show Packer URLs" })

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
end

return M
