local M = {
  "folke/todo-comments.nvim",
  event = "BufReadPost",
  dependencies = {
    "nvim-lua/telescope.nvim",
  },
}

M.config = function()
  L("todo-comments", function(todo_comments)
    todo_comments.setup()

    L("telescope", function()
      Map("n", "<Leader>tf", "<cmd>TodoTelescope keywords=FIX<CR>", { silent = true, desc = "Show Fix Comments" })
      Map("n", "<Leader>th", "<cmd>TodoTelescope keywords=HACK<CR>", { silent = true, desc = "Show Hack Comments" })
      Map("n", "<Leader>tn", "<cmd>TodoTelescope keywords=NOTE<CR>", { silent = true, desc = "Show Note Comments" })
      Map("n", "<Leader>tp", "<cmd>TodoTelescope keywords=PERF<CR>", { silent = true, desc = "Show Perf Comments" })
      Map("n", "<Leader>tt", "<cmd>TodoTelescope<CR>", { silent = true, desc = "Show All Comments" })
      Map(
        "n",
        "<Leader>tw",
        "<cmd>TodoTelescope keywords=WARNING<CR>",
        { silent = true, desc = "Show Warning Comments" }
      )
      Map("n", "<Leader>tT", "<cmd>TodoTelescope keywords=TODO<CR>", { silent = true, desc = "Show Todo Comments" })

      L("which-key", function(wk)
        wk.register({
          t = {
            name = "+todo",
            f = { "Show Fix Comments" },
            h = { "Show Hack Comments" },
            n = { "Show Note Comments" },
            p = { "Show Perf Comments" },
            t = { "Show All Comments" },
            w = { "Show Warning Comments" },
            T = { "Show Todo Comments" },
          },
        }, { prefix = "<leader>" })
      end)
    end)
  end)
end

return M
