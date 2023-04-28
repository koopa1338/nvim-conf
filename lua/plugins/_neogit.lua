local M = {
  "TimUntersberger/neogit",
  cmd = "Neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  keys = {
    { "<leader>gN", ":Neogit<CR>", desc = "Open Neogit UI" },
  },
}

M.config = function()
  local signs = L("signs").signs
  L("neogit").setup {
    disable_commit_confirmation = true,
    signs = {
      section = { signs.FoldClosed.icon, signs.FoldOpen.icon },
      item = { signs.FoldClosed.icon, signs.FoldOpen.icon },
      hung = { signs.FoldClosed.icon, signs.FoldOpen.icon },
    },
    integrations = {
      diffview = true,
    },
  }

  L("which-key", function(wk)
    wk.register({
      g = {
        N = { "Open Neogit UI" },
      },
    }, { prefix = "<leader>" })
  end)
end

return M
