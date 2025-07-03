local M = {
  "mason-org/mason-lspconfig.nvim",
  opts = { automatic_enable = false },
  event = "BufReadPre",
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {
        ui = {
          border = vim.g.border_type,
          icons = {
            package_installed = "",
            package_pending = "➤",
            package_uninstalled = "",
          },
        }
      }
    },
    "neovim/nvim-lspconfig",
  },
}

return M

