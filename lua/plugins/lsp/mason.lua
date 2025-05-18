local M = {}

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
  L("mason-lspconfig").setup {
    ensure_installed = {
      "lua_ls",
    },
    automatic_enable = false,
  }
end

return M
