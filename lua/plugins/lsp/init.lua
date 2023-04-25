local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "jose-elias-alvarez/null-ls.nvim",
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
}

M.config = function()
  L("lspconfig", function(nvim_lsp)
    local bt = vim.g.border_type
    -- lsp config
    -- overwrite handlers of language server globally
    nvim_lsp.util.default_config = vim.tbl_extend("force", nvim_lsp.util.default_config, {
      handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = bt,
        }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
          border = bt,
        }),
      },
    })

    L("lsp_utils", function(lsp_utils)
      for server, config in pairs(lsp_utils.servers(nvim_lsp)) do
        config.on_attach = lsp_utils.on_attach
        L("cmp_lsp", function(cmp_lsp)
          config.capabilities = lsp_utils.get_lsp_capabilities(cmp_lsp)
        end)
        nvim_lsp[server].setup(config)
      end
    end)

    L("lspconfig.ui.windows").default_options.border = bt

    L("which-key", function(wk)
      wk.register({
        l = {
          name = "+language",
          c = {
            name = "+code",
            a = { "Select Code Actions" },
            i = { "Show Incoming Calls (quickfix)" },
            o = { "Show Outgoing Calls (quickfix)" },
          },
          d = { "Jump to Definition" },
          f = { "Format File" },
          j = { "Jump to Next Diagnostic" },
          k = { "Jump to Previous Diagnostic" },
          l = { "Line Diagnostics" },
          r = { "Rename under Cursor" },
          s = { "Show Signature Help" },
          t = {
            name = "+finder",
            d = { "Show Diagnostics (Current Buffer)" },
            i = { "Show Implementations" },
            r = { "Show References" },
            s = { "Show Document Symbols" },
            D = { "Show Diagnostics" },
            S = { "Show Workspace Symbols" },
          },
          D = { "Show Declaration" },
          T = { "Show Type Definition" },
        },
        K = { "Show Documentation" },
      }, { prefix = "<leader>" })
    end)
  end)
end

return M
