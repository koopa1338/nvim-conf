-- 72-column line length for git commit / patch / rebase buffers
vim.api.nvim_create_autocmd("FileType",
  {
    pattern = { "gitcommit", "gitrebase", "gitpatch" },
    callback = function() vim.opt_local.textwidth = 72 end,
  }
)

return {
  "stevearc/conform.nvim",
  opts = {
    -- skip formatters not present on disk, so cascaded lists
    -- gracefully fall through to the next candidate then LSP
    default_format_opts = {},
    formatters_by_ft = {
      -- prettier handles js/ts/tsx/json/css/html/yaml/markdown
      javascript   = { "prettier",     stop_after_first = true, lsp_format = "fallback" },
      typescript   = { "prettier",     stop_after_first = true, lsp_format = "fallback" },
      typescriptreact = { "prettier",  stop_after_first = true, lsp_format = "fallback" },
      json         = { "prettier",     stop_after_first = true, lsp_format = "fallback" },
      yaml         = { "prettier",     stop_after_first = true, lsp_format = "fallback" },
      css          = { "prettier",     stop_after_first = true, lsp_format = "fallback" },
      html         = { "prettier",     stop_after_first = true, lsp_format = "fallback" },
      markdown     = { "prettier",     stop_after_first = true, lsp_format = "fallback" },

      -- python: cascade respects pyproject.toml [tool.ruff] > [tool.black] > .pep8
      -- whichever binary is installed runs first; absent ones skip silently
      python       = { "ruff_format", "black", "autopep8", lsp_format = "fallback" },

      -- lua: stylua reads stylua.toml
      lua          = { "stylua" },

      -- rust, go, zig, etc.: LSP-only (no universal cli formatter convention)
      rust         = { lsp_format = "last" },
      go           = { lsp_format = "last" },
      zig          = { lsp_format = "last" },

      -- unhandled filetypes cause conform.format() to exit silently
    },
  },
}