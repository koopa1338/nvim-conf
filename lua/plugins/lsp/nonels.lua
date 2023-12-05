local M = {}

M.setup = function()
  L("lsp_utils", function(lsp_utils)
    L("none-ls", function(none_ls)
      none_ls.setup {
        border = vim.g.border_type,
        sources = lsp_utils.get_none_ls_sources(none_ls),
        on_attach = lsp_utils.on_attach,
      }
    end)

    -- this has to be after none ls setup so null ls has
    -- higher priority regarding configured sources
    L("mason-null-ls", function(mnl)
      mnl.setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {},
      }
    end)
  end)
end

return M
