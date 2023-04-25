local M = {}

M.setup = function()
  L("lsp_sources", function(lsp_sources)
    lsp_sources.ls = null_ls
    local opts = {
      border = vim.g.border_type,
      sources = lsp_sources.get_null_ls_sources(),
    }
    L("lsp_utils", function(lsp_utils)
      opts.on_attach = lsp_utils.on_attach
    end)
    L("null-ls", function(null_ls)
      null_ls.setup(opts)
    end)
  end)
end

return M
