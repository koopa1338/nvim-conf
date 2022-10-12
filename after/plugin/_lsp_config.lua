L("lspconfig", function(nvim_lsp)
  L("lsp_utils", function(lsp_utils)
    -- lsp config
    local custom_attach = function(client, bufnr)
      local opts = { remap = false, silent = true, buffer = bufnr }
      local capabilities = client.server_capabilities
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

      if capabilities.declarationProvider then
        Map("n", "<leader>lD", vim.lsp.buf.declaration, opts)
      else
        Map("n", "<leader>lD", function()
          lsp_utils.notify_unsupported_lsp "LSP does not support jump to declaration"
        end, opts)
      end

      if capabilities.definitionProvider then
        Map("n", "<leader>ld", vim.lsp.buf.definition, opts)
      else
        Map("n", "<leader>ld", function()
          lsp_utils.notify_unsupported_lsp "LSP does not support jump to defenition"
        end, opts)
      end

      if capabilities.typeDefinitionProvider then
        Map("n", "<leader>lT", vim.lsp.buf.type_definition, opts)
      else
        Map("n", "<leader>lT", function()
          lsp_utils.notify_unsupported_lsp "LSP does not support show document type defenition"
        end, opts)
      end

      if capabilities.renameProvider then
        Map("n", "<leader>lr", vim.lsp.buf.rename, opts)
      else
        Map("n", "<leader>lr", function()
          lsp_utils.notify_unsupported_lsp "LSP does not support show rename"
        end, opts)
      end

      if capabilities.documentFormattingProvider then
        Map("n", "<leader>lf", function()
          if vim.version().minor >= 8 then
            vim.lsp.buf.format { async = true }
          else
            vim.lsp.buf.formatting()
          end
        end, opts)
      else
        Map("n", "<leader>lf", function()
          lsp_utils.notify_unsupported_lsp "LSP does not support show formatting"
        end, opts)
      end

      if capabilities.signatureHelpProvider then
        Map("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
      else
        Map("n", "<leader>ls", function()
          lsp_utils.notify_unsupported_lsp "LSP does not support signature help"
        end, opts)
      end

      if capabilities.codeActionProvider then
        Map({ "n", "v" }, "<leader>lca", vim.lsp.buf.code_action, opts)
      else
        Map({ "n", "v" }, "<leader>lca", function()
          lsp_utils.notify_unsupported_lsp "LSP does not support code actions"
        end, opts)
      end

      if capabilities.hoverProvider then
        Map("n", "K", vim.lsp.buf.hover, opts)
      else
        Map("n", "K", function()
          lsp_utils.notify_unsupported_lsp "LSP does not support hover information"
        end, opts)
      end

      -- Set autocommands conditional on server_capabilities
      if capabilities.documentHighlightProvider then
        local lsp_highlight_au = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_create_autocmd({ "CursorHold" }, {
          group = lsp_highlight_au,
          buffer = 0,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved" }, {
          group = lsp_highlight_au,
          buffer = 0,
          callback = vim.lsp.buf.clear_references,
        })
      end

      if capabilities.documentSymbolProvider then
        Map("n", "<leader>lts", "<cmd>Telescope lsp_document_symbols<CR>", { silent = true })
      else
        Map("n", "<leader>lts", function()
          lsp_utils.notify_unsupported_lsp "LSP does not support showing document symbols"
        end, { silent = true })
      end

      if capabilities.workspaceSymbolProvider then
        Map("n", "<leader>ltS", "<cmd>Telescope lsp_workspace_symbols<CR>", { silent = true })
      else
        Map("n", "<leader>ltS", function()
          lsp_utils.notify_unsupported_lsp "LSP does not support showing workspace symbols"
        end, { silent = true })
      end

      if capabilities.referencesProvider then
        Map("n", "<leader>ltr", "<cmd>Telescope lsp_references<CR>", { silent = true })
      else
        Map("n", "<leader>ltr", function()
          lsp_utils.notify_unsupported_lsp "LSP does not support showing references"
        end, { silent = true })
      end

      if capabilities.implementationProvider then
        Map("n", "<leader>lti", "<cmd>Telescope lsp_implementations<CR>", { silent = true })
      else
        Map("n", "<leader>lti", function()
          lsp_utils.notify_unsupported_lsp "LSP does not support showing implementations"
        end, { silent = true })
      end

      Map("n", "<leader>lci", vim.lsp.buf.incoming_calls, opts)
      Map("n", "<leader>lco", vim.lsp.buf.outgoing_calls, opts)
      local float_opts = { scope = "l", source = "if_many" }
      Map("n", "<leader>ll", function()
        vim.diagnostic.open_float(float_opts)
      end, opts)
      Map("n", "<leader>lj", function()
        vim.diagnostic.goto_next { float = float_opts }
      end, opts)
      Map("n", "<leader>lk", function()
        vim.diagnostic.goto_prev { float = float_opts }
      end, opts)
    end

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

    local bt = vim.g.border_type
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

    local mason = L "mason-registry"
    local cmp_lsp = L "cmp_lsp"
    for server, config in pairs(lsp_utils.servers(mason)) do
      config.on_attach = custom_attach
      config.capabilities = lsp_utils.get_lsp_capabilities(cmp_lsp)
      nvim_lsp[server].setup(config)
    end

    L("lspconfig.ui.windows").default_options.border = bt
  end)
end)
