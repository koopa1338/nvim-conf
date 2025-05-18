local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "nvimtools/none-ls.nvim",
    "nvim-lua/plenary.nvim",
    {
      "williamboman/mason.nvim",
      dependencies = {
        "williamboman/mason-lspconfig",
        {
          "jay-babu/mason-null-ls.nvim",
          event = { "BufReadPre", "BufNewFile" },
          dependencies = {
            "nvimtools/none-ls.nvim",
          },
        },
      },
    },
    {
      "j-hui/fidget.nvim",
      opts = {
        notification = {
          window = {
            border = vim.g.border_type,
            border_hl = "FloatBorder",
            winblend = 0,
          },
        },
      },
    },
    { "folke/neodev.nvim", config = true, ft = "lua" },
  },
  event = { "BufReadPre" },
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
      local config = {
        on_attach = lsp_utils.on_attach,
        on_init = lsp_utils.on_init,
        capabilities = lsp_utils.get_lsp_capabilities(cmp_lsp),
      }
      L("mason-lspconfig", function(masonlsp)
        masonlsp.setup {
          handlers = {
            function(server_name)
              nvim_lsp[server_name].setup(config)
            end,
          },
        }
      end)

      for server, conf in pairs(lsp_utils.servers(nvim_lsp)) do
        conf.on_init = config.on_init
        conf.on_attach = config.on_attach
        conf.capabilities = config.capabilities
        nvim_lsp[server].setup(conf)
      end
    end)

    L("lspconfig.ui.windows").default_options.border = bt
  end)

  -- NOTE: this has to be after the lsp config so none ls action
  -- take higher priority then lsp (e.g. formatting)
  L("plugins.lsp.mason").setup()
  L("plugins.lsp.nonels").setup()
end

return M
