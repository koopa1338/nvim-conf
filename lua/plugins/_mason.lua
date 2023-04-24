local M = {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig",
    {
      "jay-babu/mason-null-ls.nvim",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
        "jose-elias-alvarez/null-ls.nvim",
      },
    },
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
  L("mason-null-ls").setup {
    ensure_installed = {},
    automatic_installation = false,
    handlers = {},
  }
  L("plugins.lsp.nullls").setup()
end

return M
