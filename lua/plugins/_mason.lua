local M = {
  "williamboman/mason.nvim",
  event = "VeryLazy",
  config = true,
}

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
