local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "jose-elias-alvarez/null-ls.nvim",
    "nvim-lua/plenary.nvim",
    {
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
    },
  },
  event = { "BufReadPre", "BufNewFile" },
  cmd = "Mason",
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
      local cmp_lsp = L "cmp_lsp"
      local capabilities = lsp_utils.get_lsp_capabilities(cmp_lsp)
      L("mason-lspconfig", function(masonlsp)
        masonlsp.setup_handlers {
          function(server_name)
            local config = {
              on_attach = lsp_utils.on_attach,
              capabilities = capabilities,
            }
            nvim_lsp[server_name].setup(config)
          end,
        }
      end)

      for server, config in pairs(lsp_utils.servers(nvim_lsp)) do
        config.on_attach = lsp_utils.on_attach
        config.capabilities = capabilities
        nvim_lsp[server].setup(config)
      end
    end)

    L("lspconfig.ui.windows").default_options.border = bt
  end)

  -- NOTE: this has to be after the lsp config so null ls action
  -- take higher priority then lsp (e.g. formatting)
  L("plugins.lsp.mason").setup()
  L("plugins.lsp.nullls").setup()
end

return M
