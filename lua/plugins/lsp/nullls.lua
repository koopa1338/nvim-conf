local M = {}

M.setup = function()
  L("lsp_utils", function(lsp_utils)
    L("null-ls", function(null_ls)
      null_ls.setup {
        border = vim.g.border_type,
        sources = lsp_utils.get_null_ls_sources(null_ls),
        on_attach = lsp_utils.on_attach,
      }
    end)
  end)
end

return M
