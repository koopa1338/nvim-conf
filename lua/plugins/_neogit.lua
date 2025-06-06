local M = {
  "NeogitOrg/neogit",
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
    disable_builtin_notifications = true,
    signs = {
      section = { signs.FoldClosed.icon, signs.FoldOpen.icon },
      item = { signs.FoldClosed.icon, signs.FoldOpen.icon },
      hung = { signs.FoldClosed.icon, signs.FoldOpen.icon },
    },
    integrations = {
      telescope = true,
      diffview = true,
    },
    popup = {
      kind = "floating",
    },
    commit_popup = {
      kind = "vsplit",
    },
    mappings = {
      status = {
        ["o"] = "Toggle",
        ["<tab>"] = "OpenTree",
      },
      popup = {
        ["P"] = "PullPopup",
        ["p"] = "PushPopup",
      },
    },
  }
end

return M
