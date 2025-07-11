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

M.method_mappings = {
  ["textDocument/declaration"] = {
    {
      mode = "n",
      keys = "<leader>lD",
      callback = function()
        vim.lsp.buf.declaration { loclist = true }
      end,
      desc = "Show Declaration",
      error = "LSP does not support jump to declaration",
      buffer = true,
    },
    {
      mode = "n",
      keys = "<leader>lti",
      callback = "<cmd>Telescope lsp_implementations<CR>",
      desc = "Show Implementations",
      error = "LSP does not support showing implementations",
      buffer = false,
    },
  },
  ["textDocument/definition"] = {
    {
      mode = "n",
      keys = "<leader>ld",
      callback = function()
        vim.lsp.buf.definition { loclist = true }
      end,
      desc = "Jump to Definition",
      error = "LSP does not support jump to defenition",
      buffer = true,
    },
  },
  ["textDocument/typeDefinition"] = {
    {
      mode = "n",
      keys = "<leader>lT",
      callback = function()
        vim.lsp.buf.type_definition { loclist = true }
      end,
      desc = "Show Type Definition",
      error = "LSP does not support show document type definition",
      buffer = true,
    },
  },
  ["textDocument/rename"] = {
    {
      mode = "n",
      keys = "<leader>lr",
      callback = vim.lsp.buf.rename,
      desc = "Rename under Cursor",
      error = "LSP does not support show rename",
      buffer = true,
    },
  },
  ["textDocument/formatting"] = {
    {
      mode = { "n", "v" },
      keys = "<leader>lf",
      callback = require("conform").format,
      desc = "Format File",
      error = "LSP does not support formatting",
      buffer = true,
    },
  },
  ["textDocument/signatureHelp"] = {
    {
      mode = "n",
      keys = "<leader>ls",
      callback = function()
        vim.lsp.buf.signature_help {
          border = vim.g.border_type,
        }
      end,
      desc = "Show Signature Help",
      error = "LSP does not support signature help",
      buffer = true,
    },
  },
  ["textDocument/codeAction"] = {
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
      desc = "Select Code Actions (quickfix)",
      error = "LSP does not support code actions",
      buffer = true,
    },
    {
      mode = { "n", "v" },
      keys = "<leader>lca",
      callback = vim.lsp.buf.code_action,
      desc = "Select Code Actions",
      error = "LSP does not support code actions",
      buffer = true,
    },
  },
  ["textDocument/hover"] = {
    {
      mode = "n",
      keys = "K",
      callback = function()
        vim.lsp.buf.hover {
          border = vim.g.border_type,
        }
      end,
      desc = "Show Hover Information",
      error = "LSP does not support hover information",
      buffer = true,
    },
  },
  ["textDocument/documentSymbol"] = {
    {
      mode = "n",
      keys = "<leader>lts",
      callback = "<cmd>Telescope lsp_document_symbols<CR>",
      desc = "Show Document Symbols",
      error = "LSP does not support showing document symbols",
      buffer = false,
    },
  },
  ["workspace/symbol"] = {
    {
      mode = "n",
      keys = "<leader>ltS",
      callback = "<cmd>Telescope lsp_workspace_symbols<CR>",
      desc = "Show Workspace Symbols",
      error = "LSP does not support showing workspace symbols",
      buffer = false,
    },
  },
  ["textDocument/references"] = {
    {
      mode = "n",
      keys = "<leader>ltr",
      callback = "<cmd>Telescope lsp_references<CR>",
      desc = "Show References",
      error = "LSP does not support showing references",
      buffer = false,
    },
  },
  ["textDocument/inlayHint"] = {
    {
      mode = "n",
      keys = "<leader>lI",
      callback = function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end,
      desc = "Toggle inlay hints",
      error = "LSP does not support inlay hints",
      buffer = false,
    },
  },
}

M.map_providers = function(client, bufnr)
  for method, mappings in pairs(M.method_mappings) do
    for _, map in ipairs(mappings) do
      if client.supports_method(method) then
        local opts = { silent = true, desc = map.desc }
        if map.buffer then
          opts.buffer = bufnr
        end
        Map(map.mode, map.keys, map.callback, opts)
      else
        Map(map.mode, map.keys, function()
          notify_unsupported_lsp(map.error, map.desc)
        end, { silent = true, desc = map.desc })
      end
    end
  end
end

return M
