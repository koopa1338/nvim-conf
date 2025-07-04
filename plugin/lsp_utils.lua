local M = {}

M.get_lsp_capabilities = function(cmp_lsp)
  if cmp_lsp then
    return cmp_lsp.default_capabilites()
  end

  return vim.lsp.protocol.make_client_capabilities()
end

local notify_unsupported_lsp = function(message, title)
  vim.notify(message, vim.log.levels.INFO, { title = title or "LSP Provider not supported" })
end

M.supported = {
  declarationProvider = false,
  definitionProvider = false,
  typeDefinitionProvider = false,
  renameProvider = false,
  documentFormattingProvider = false,
  signatureHelpProvider = false,
  codeActionProvider = false,
  hoverProvider = false,
  documentSymbolProvider = false,
  workspaceSymbolProvider = false,
  referencesProvider = false,
  implementationProvider = false,
}

local provider_mapping = {
  declarationProvider = {
    {
      mode = "n",
      keys = "<leader>lD",
      callback = function()
        vim.lsp.buf.declaration { loclist = true }
      end,
      method = "textDocument/declaration",
      desc = "Show Declaration",
      error = "LSP does not support jump to declaration",
      buffer = true,
    },
  },
  definitionProvider = {
    {
      mode = "n",
      keys = "<leader>ld",
      callback = function()
        vim.lsp.buf.definition { loclist = true }
      end,
      method = "textDocument/definition",
      desc = "Jump to Definition",
      error = "LSP does not support jump to defenition",
      buffer = true,
    },
  },
  typeDefinitionProvider = {
    {
      mode = "n",
      keys = "<leader>lT",
      callback = function()
        vim.lsp.buf.type_definition { loclist = true }
      end,
      method = "textDocument/typeDefinition",
      desc = "Show Type Definition",
      error = "LSP does not support show document type definition",
      buffer = true,
    },
  },
  renameProvider = {
    {
      mode = "n",
      keys = "<leader>lr",
      callback = vim.lsp.buf.rename,
      method = "textDocument/rename",
      desc = "Rename under Cursor",
      error = "LSP does not support show rename",
      buffer = true,
    },
  },
  documentFormattingProvider = {
    {
      mode = "n",
      keys = "<leader>lf",
      callback = function()
        if vim.version().minor >= 8 then
          vim.lsp.buf.format() -- { async = true }
        else
          vim.lsp.buf.formatting()
        end
      end,
      method = "textDocument/formatting",
      desc = "Format File",
      error = "LSP does not support formatting",
      buffer = true,
    },
  },
  signatureHelpProvider = {
    {
      mode = "n",
      keys = "<leader>ls",
      callback = function()
        vim.lsp.buf.signature_help {
          border = vim.g.border_type,
        }
      end,
      method = "textDocument/signatureHelp",
      desc = "Show Signature Help",
      error = "LSP does not support signature help",
      buffer = true,
    },
  },
  codeActionProvider = {
    {
      mode = { "n", "v" },
      keys = "<leader>lcA",
      callback = function()
        vim.lsp.buf.code_action {
          context = {
            only = {
              "quickfix",
            },
            diagnostics = {},
          },
        }
      end,
      method = "textDocument/codeAction",
      desc = "Select Code Actions (quickfix)",
      error = "LSP does not support code actions",
      buffer = true,
    },
    {
      mode = { "n", "v" },
      keys = "<leader>lca",
      callback = vim.lsp.buf.code_action,
      method = "textDocument/codeAction",
      desc = "Select Code Actions",
      error = "LSP does not support code actions",
      buffer = true,
    },
  },
  hoverProvider = {
    {
      mode = "n",
      keys = "K",
      callback = function()
        vim.lsp.buf.hover {
          border = vim.g.border_type,
        }
      end,
      method = "textDocument/hover",
      desc = "Show Hover Information",
      error = "LSP does not support hover information",
      buffer = true,
    },
  },
  documentSymbolProvider = {
    {
      mode = "n",
      keys = "<leader>lts",
      callback = "<cmd>Telescope lsp_document_symbols<CR>",
      method = "textDocument/documentSymbol",
      desc = "Show Document Symbols",
      error = "LSP does not support showing document symbols",
      buffer = false,
    },
  },
  workspaceSymbolProvider = {
    {
      mode = "n",
      keys = "<leader>ltS",
      callback = "<cmd>Telescope lsp_workspace_symbols<CR>",
      method = "workspace/symbol",
      desc = "Show Workspace Symbols",
      error = "LSP does not support showing workspace symbols",
      buffer = false,
    },
  },
  referencesProvider = {
    {
      mode = "n",
      keys = "<leader>ltr",
      callback = "<cmd>Telescope lsp_references<CR>",
      method = "textDocument/references",
      desc = "Show References",
      error = "LSP does not support showing references",
      buffer = false,
    },
  },
  implementationProvider = {
    {
      mode = "n",
      keys = "<leader>lti",
      callback = "<cmd>Telescope lsp_implementations<CR>",
      method = "textDocument/declaration",
      desc = "Show Implementations",
      error = "LSP does not support showing implementations",
      buffer = false,
    },
  },
  inlayHintProvider = {
    {
      mode = "n",
      keys = "<leader>lI",
      callback = function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end,
      method = "textDocument/inlayHint",
      desc = "Toggle inlay hints",
      error = "LSP does not support inlay hints",
      buffer = false,
    },
  },
}

M.map_providers = function(client, bufnr)
  for provider, mappings in pairs(provider_mapping) do
    for _, map in ipairs(mappings) do
      if client.supports_method(map.method) then
        local opts = { silent = true, desc = map.desc }
        if map.buffer then
          opts.buffer = bufnr
        end
        Map(map.mode, map.keys, map.callback, opts)
        M.supported[provider] = true
      end
    end
  end
end

M.map_unsupported = function()
  for provider, supported in pairs(M.supported) do
    if not supported then
      local prov = provider_mapping[provider]
      for _, map in ipairs(prov) do
        Map(map.mode, map.keys, function()
          notify_unsupported_lsp(map.error, map.desc)
        end, { silent = true, desc = map.desc })
      end
    end
  end
end

return M
