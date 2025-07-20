local lsp_files = {}
local lsp_dir = vim.fn.stdpath "config" .. "/lsp/"

for _, file in ipairs(vim.fn.globpath(lsp_dir, "*.lua", false, true)) do
  -- Read the first line of the file
  local f = io.open(file, "r")
  local first_line = f and f:read "*l" or ""
  if f then
    f:close()
  end
  -- Only include the file if it doesn't start with "-- disable"
  if not first_line:match "^%-%- disable" then
    local name = vim.fn.fnamemodify(file, ":t:r") -- `:t` gets filename, `:r` removes extension
    table.insert(lsp_files, name)
  end
end

require "mason"
L("mason-lspconfig", function(mlsp)
  local servers = mlsp.get_installed_servers()
  lsp_files = vim.tbl_extend("keep", lsp_files, servers)
end)

L("lsp_utils", function(lsp_utils)
  -- register mappings after dynamic registration
  -- hopefully we can do this later with a lsp-event and autocmd
  local orig_handler = vim.lsp.handlers["client/registerCapability"]
  vim.lsp.handlers["client/registerCapability"] = function(err, result, ctx)
    local orig_result = orig_handler(err, result, ctx)
    for _, reg in ipairs(result.registrations) do
      local mapping = lsp_utils.method_mappings[reg.method]
      if mapping then
        for _, m in ipairs(mapping) do
          Map(m.mode, m.keys, m.callback, { silent = true, desc = m.desc })
        end
      end
    end

    return orig_result
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if not client then
        return
      end
      local bufnr = ev.buf

      lsp_utils.map_providers(client, bufnr)
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
        vim.diagnostic.jump { count = 1, float = true, severity = { min = vim.diagnostic.severity.WARN } }
      end, { silent = true, buffer = bufnr, desc = "Jump to Next Diagnostic" })
      Map("n", "<leader>lk", function()
        vim.diagnostic.jump { count = -1, float = true, severity = { min = vim.diagnostic.severity.WARN } }
      end, { silent = true, buffer = bufnr, desc = "Jump to Previous Diagnostic" })
    end,
  })

  local capabilities = require("blink.cmp").get_lsp_capabilities()
  -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
  vim.lsp.config("*", {
    capabilities = capabilities,
  })

  for _, name in ipairs(lsp_files) do
    vim.lsp.enable(name)
  end
end)

local function restart_lsp(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local clients
  if vim.lsp.get_clients then
    clients = vim.lsp.get_clients { bufnr = bufnr }
  else
    ---@diagnostic disable-next-line: deprecated
    clients = vim.lsp.get_active_clients { bufnr = bufnr }
  end

  for _, client in ipairs(clients) do
    vim.lsp.stop_client(client.id)
  end

  vim.defer_fn(function()
    vim.cmd "edit"
  end, 100)
end

vim.api.nvim_create_user_command("LspRestart", function()
  restart_lsp()
end, {})

vim.api.nvim_create_user_command("LspStop", function(opts)
  for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
    if opts.args == "" or opts.args == client.name then
      client:stop(true)
      vim.notify(client.name .. ": stopped")
    end
  end
end, {
  desc = "Stop all LSP clients or a specific client attached to the current buffer.",
  nargs = "?",
  complete = function(_, _, _)
    local clients = vim.lsp.get_clients { bufnr = 0 }
    local client_names = {}
    for _, client in ipairs(clients) do
      table.insert(client_names, client.name)
    end
    return client_names
  end,
})

vim.api.nvim_create_user_command("LspInfo", function()
  vim.cmd "silent checkhealth vim.lsp"
end, {
  desc = "Get all the information about all LSP attached",
})

local function lsp_status()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients and vim.lsp.get_clients { bufnr = bufnr }

  if #clients == 0 then
    print "󰅚 No LSP clients attached"
    return
  end

  print("󰒋 LSP Status for buffer " .. bufnr .. ":")
  print "─────────────────────────────────"

  for i, client in ipairs(clients) do
    print(string.format("󰌘 Client %d: %s (ID: %d)", i, client.name, client.id))
    print("  Root: " .. (client.config.root_dir or "N/A"))
    print("  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))

    -- Check capabilities
    local caps = client.server_capabilities
    local features = {}
    if caps.completionProvider then
      table.insert(features, "completion")
    end
    if caps.hoverProvider then
      table.insert(features, "hover")
    end
    if caps.definitionProvider then
      table.insert(features, "definition")
    end
    if caps.referencesProvider then
      table.insert(features, "references")
    end
    if caps.renameProvider then
      table.insert(features, "rename")
    end
    if caps.codeActionProvider then
      table.insert(features, "code_action")
    end
    if caps.documentFormattingProvider then
      table.insert(features, "formatting")
    end

    print("  Features: " .. table.concat(features, ", "))
    print ""
  end
end

vim.api.nvim_create_user_command("LspStatus", lsp_status, { desc = "Show detailed LSP status" })
