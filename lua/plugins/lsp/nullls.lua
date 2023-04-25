local M = {}

M.setup = function(null_ls)
  L("lsp_sources", function(lsp_sources)
    lsp_sources.ls = null_ls
    local opts = {
      border = vim.g.border_type,
      sources = lsp_sources.get_null_ls_sources(),
    }
    L("lsp_utils", function(ls_utils)
      opts.on_attach = lsp_utils.on_attach
    end)
    null_ls.setup(opts)
  end)
end

return M
