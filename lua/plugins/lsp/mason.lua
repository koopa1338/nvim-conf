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
  }
  L("mason-null-ls").setup {
    ensure_installed = {},
    automatic_installation = false,
    handlers = {},
  }
end

return M
