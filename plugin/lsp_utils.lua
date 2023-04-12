local proto, log_lvl = vim.lsp.protocol, vim.lsp.levels
local unsupported_title = "LSP Provider not supported"
local M = {}

M.get_lsp_capabilities = function(cmp_lsp)
  local capabilities = proto.make_client_capabilities()
  -- nvim-cmp supports additional completion capabilities
  if cmp_lsp then
    capabilities = cmp_lsp.update_capabilities(proto.make_client_capabilities())
  end

  return capabilities
end

M.notify_unsupported_lsp = function(message, title)
  vim.notify(message, log_lvl.INFO, { title = title or unsupported_title })
end

M.servers = function()
  local server_configs = {}
  L("user.lsp", function(custom)
    for lsp, config in pairs(custom) do
      server_configs[lsp] = config or {}
    end
  end)

  return server_configs
end

return M
