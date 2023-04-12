local M = {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig",
  },
  event = "VeryLazy",
}

M.config = function()
  L("mason").setup {}
  L("mason-lspconfig").setup {}
end

M.opts = {
  ui = {
    border = vim.g.border_type,
    icons = {
      package_installed = "",
      package_pending = "➤",
      package_uninstalled = "",
    },
  },
}

return M
