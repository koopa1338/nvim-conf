local proto, log_lvl = vim.lsp.protocol, vim.lsp.levels
local unsupported_title = "LSP Provider not supported"
local M = {}

M.get_runtime_path = function()
  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")
  table.insert(runtime_path, "plugin/?.lua")
  table.insert(runtime_path, "plugin/?/init.lua")
  return runtime_path
end

M.get_lsp_capabilities = function(cmp_lsp)
  local capabilities = proto.make_client_capabilities()
  -- nvim-cmp supports additional completion capabilities
  if cmp_lsp then
    capabilities = cmp_lsp.update_capabilities(proto.make_client_capabilities())
  end

  return capabilities
end

local notify_unsupported_lsp = function(message, title)
  vim.notify(message, log_lvl.INFO, { title = title or unsupported_title })
end

M.servers = function(nvim_lsp)
  local servers = {}
  L("user_settings", function(settings)
    settings.lsp_servers(nvim_lsp)
  end)
  return servers
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
    mode = "n",
    keys = "<leader>lD",
    callback = vim.lsp.buf.declaration,
    desc = "Show Declaration",
    error = "LSP does not support jump to declaration",
    buffer = true,
  },
  definitionProvider = {
    mode = "n",
    keys = "<leader>ld",
    callback = vim.lsp.buf.definition,
    desc = "Jump to Definition",
    error = "LSP does not support jump to defenition",
    buffer = true,
  },
  typeDefinitionProvider = {
    mode = "n",
    keys = "<leader>lT",
    callback = vim.lsp.buf.type_definition,
    desc = "Show Type Definition",
    error = "LSP does not support show document type definition",
    buffer = true,
  },
  renameProvider = {
    mode = "n",
    keys = "<leader>lr",
    callback = vim.lsp.buf.rename,
    desc = "Rename under Cursor",
    error = "LSP does not support show rename",
    buffer = true,
  },
  documentFormattingProvider = {
    mode = "n",
    keys = "<leader>lf",
    callback = function()
      if vim.version().minor >= 8 then
        vim.lsp.buf.format() -- { async = true }
      else
        vim.lsp.buf.formatting()
      end
    end,
    desc = "Format File",
    error = "LSP does not support formatting",
    buffer = true,
  },
  signatureHelpProvider = {
    mode = "n",
    keys = "<leader>ls",
    callback = vim.lsp.buf.signature_help,
    desc = "Show Signature Help",
    error = "LSP does not support signature help",
    buffer = true,
  },
  codeActionProvider = {
    mode = { "n", "v" },
    keys = "<leader>lca",
    callback = vim.lsp.buf.code_action,
    desc = "Select Code Actions",
    error = "LSP does not support code actions",
    buffer = true,
  },
  hoverProvider = {
    mode = "n",
    keys = "K",
    callback = vim.lsp.buf.hover,
    desc = "Show Hover Information",
    error = "LSP does not support hover information",
    buffer = true,
  },
  documentSymbolProvider = {
    mode = "n",
    keys = "<leader>lts",
    callback = "<cmd>Telescope lsp_document_symbols<CR>",
    desc = "Show Document Symbols",
    error = "LSP does not support showing document symbols",
    buffer = false,
  },
  workspaceSymbolProvider = {
    mode = "n",
    keys = "<leader>ltS",
    callback = "<cmd>Telescope lsp_workspace_symbols<CR>",
    desc = "Show Workspace Symbols",
    error = "LSP does not support showing workspace symbols",
    buffer = false,
  },
  referencesProvider = {
    mode = "n",
    keys = "<leader>ltr",
    callback = "<cmd>Telescope lsp_references<CR>",
    desc = "Show References",
    error = "LSP does not support showing references",
    buffer = false,
  },
  implementationProvider = {
    mode = "n",
    keys = "<leader>lti",
    callback = "<cmd>Telescope lsp_implementations<CR>",
    desc = "Show Implementations",
    error = "LSP does not support showing implementations",
    buffer = false,
  },
}

local map_providers = function(capabilities, bufnr)
  for provider, prov_opts in pairs(provider_mapping) do
    local opts = { silent = true, desc = prov_opts.desc }
    if prov_opts.buffer then
      opts.buffer = bufnr
    end
    if capabilities[provider] then
      Map(prov_opts.mode, prov_opts.keys, prov_opts.callback, opts)
      M.supported[provider] = true
    end
  end
end

local map_unsupported = function()
  for provider, supported in pairs(M.supported) do
    if not supported then
      local prov = provider_mapping[provider]
      Map(prov.mode, prov.keys, function()
        notify_unsupported_lsp(prov.error, prov.desc)
      end, { silent = true, desc = prov.desc })
    end
  end
end

M.on_attach = function(client, bufnr)
  local capabilities = client.server_capabilities
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  map_providers(capabilities, bufnr)
  map_unsupported()
  Map(
    "n",
    "<leader>lci",
    vim.lsp.buf.incoming_calls,
    { silent = true, buffer = bufnr, desc = "Show Incoming Calls (quickfix)" }
  )
  Map(
    "n",
    "<leader>lco",
    vim.lsp.buf.outgoing_calls,
    { silent = true, buffer = bufnr, desc = "Show Outgoing Calls (quickfix)" }
  )
  local float_opts = { scope = "l", source = "if_many" }
  Map("n", "<leader>ll", function()
    vim.diagnostic.open_float(float_opts)
  end, { silent = true, buffer = bufnr, desc = "Line Diagnostics" })
  Map("n", "<leader>lj", function()
    vim.diagnostic.goto_next { float = float_opts }
  end, { silent = true, buffer = bufnr, desc = "Jump to Next Diagnostic" })
  Map("n", "<leader>lk", function()
    vim.diagnostic.goto_prev { float = float_opts }
  end, { silent = true, buffer = bufnr, desc = "Jump to Previous Diagnostic" })
end

return M
