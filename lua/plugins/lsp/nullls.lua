local M = {}

M.setup = function(custom_attach)
  local null_ls = L "null-ls"
  L("lsp_sources", function(lsp_sources)
    lsp_sources.ls = null_ls
    null_ls.setup {
      border = vim.g.border_type,
      sources = lsp_sources.get_null_ls_sources(),
      on_attach = custom_attach,
    }
  end)
end

return M
