local M = {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig",
  },
  event = "VeryLazy",
}

M.config = function()
  L("mason").setup {
    ui = {
      border = vim.g.border_type,
      icons = {
        package_installed = "",
        package_pending = "➤",
        package_uninstalled = "",
      },
    },
  }
  L("mason-lspconfig").setup {}
end

return M
