local M = {
  "mason-org/mason.nvim",
  opts = {},
}

M.setup = function()
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
end

return M
