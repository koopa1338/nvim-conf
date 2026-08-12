local M = {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettier", stop_after_first = true, lsp_format = "fallback" },
      typescript = { "prettier", stop_after_first = true, lsp_format = "fallback" },
      typescriptreact = { "prettier", stop_after_first = true, lsp_format = "fallback" },
      lua = { "stylua" },
      python = { "black", lsp_format = "fallback" },
      go = { lsp_format = "last" },
      gitcommit = { "editorconfig", lsp_format = "never", format_opts = { cols = 72 } },
    },
    default_format_opts = {},
  },
}

return M
