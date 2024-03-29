local M = {
  "axieax/urlview.nvim",
  event = "BufReadPost",
}

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
  end)
end

return M
