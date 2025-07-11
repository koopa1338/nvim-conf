local M = {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier", stop_after_first = true, lsp_format = "fallback" },
      typescript = { "prettier", stop_after_first = true, lsp_format = "fallback" },
      typescriptreact = { "prettier", stop_after_first = true, lsp_format = "fallback" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
}

return M
