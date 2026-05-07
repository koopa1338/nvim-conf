local lsp_files = {}
local lsp_dir = vim.fn.stdpath "config" .. "/lsp/"
local lsp_configs = {}

for _, file in ipairs(vim.fn.globpath(lsp_dir, "*.lua", false, true)) do
  -- Read the first line of the file to allow disabling with a comment flag.
  local f = io.open(file, "r")
  local first_line = f and f:read "*l" or ""
  if f then
    f:close()
  end
  if not first_line:match "^%-%- disable" then
    local name = vim.fn.fnamemodify(file, ":t:r") -- `:t` gets filename, `:r` removes extension
    table.insert(lsp_files, name)
    -- Keep existing behaviour of loading the config table. This registers the
    -- server configuration with nvim but we will not enable every server at startup.
    -- We still call vim.lsp.config so the server is known to nvim.
    lsp_configs[name] = dofile(file)
    vim.lsp.config(name, lsp_configs[name])
  end
end

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

  L("mason-lspconfig", function(mlsp)
    for _, name in ipairs(mlsp.get_installed_servers()) do
      if not vim.tbl_contains(lsp_files, name) then
        table.insert(lsp_files, name)
      end
    end
  end)

local function server_filetypes(name, cfg)
  -- Return a list of filetypes for a server, trying multiple fallbacks.
  if cfg and cfg.filetypes then
    if type(cfg.filetypes) == "string" then
      return { cfg.filetypes }
    end
    return cfg.filetypes
  end

  local ok, registered = pcall(function() return vim.lsp.config(name) end)
  if ok and registered and registered.filetypes then
    local fts = registered.filetypes
    return type(fts) == "string" and { fts } or fts
  end

  return nil
end

local function server_matches_filetype(name, cfg, ft)
  local fts = server_filetypes(name, cfg)
  if not fts then
    return false
  end
  for _, v in ipairs(fts) do
    if v == ft then
      return true
    end
  end
  return false
end

local function enable_for_buffer(name, bufnr)
  for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
    if client.name == name then return end
  end
  vim.lsp.enable(name)
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "FileType" }, {
  callback = function(ev)
    local ft = vim.api.nvim_get_option_value("filetype", { buf = ev.buf })
    for _, name in ipairs(lsp_files) do
      if server_matches_filetype(name, lsp_configs[name], ft) then
        enable_for_buffer(name, ev.buf)
      end
    end
  end,
})

-- Provide a manual command to enable servers by name (keeps behaviour explicit).
vim.api.nvim_create_user_command("LspEnable", function(opts)
  local name = opts.args
  if name == "" then
    vim.notify("Usage: :LspEnable <server-name>", vim.log.levels.INFO)
    return
  end
  if not lsp_configs[name] then
    vim.notify("No server config found for: " .. name, vim.log.levels.ERROR)
    return
  end
  vim.lsp.enable(name)
end, { nargs = 1, desc = "Enable an LSP server by name" })

-- Restore compatibility: enable any discovered servers at startup. This mirrors
-- previous behaviour and ensures mason-installed servers (like markdown
-- servers) are available immediately when opening a file. We wrap in pcall to
-- avoid hard failures if a server can't be enabled.
for _, name in ipairs(lsp_files) do
  pcall(vim.lsp.enable, name)
end

-- Debug helper: inspect discovered servers and configs
vim.api.nvim_create_user_command("DebugLspSetup", function()
  print("lsp_files: " .. vim.inspect(lsp_files))
  print("lsp_configs keys: " .. vim.inspect(vim.tbl_keys(lsp_configs)))
  local ok, _ = pcall(require, "mason-lspconfig")
  print("mason-lspconfig loaded: " .. tostring(ok))
end, { nargs = 0 })
end)

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

local function start_remote(name, container)
  local cfg = vim.deepcopy(lsp_configs[name])
  if not cfg then
    vim.notify("no config found for server " .. name, vim.log.levels.ERROR)
    return
  end

  local cmd = { "podman", "exec", "-i" }
  local lsp_cmd = cfg.cmd[1]
  if cfg.container then
    if cfg.container.env then
      for k, v in pairs(cfg.container.env) do
        table.insert(cmd, "-e")
        table.insert(cmd, k .. "=" .. v)
      end
    end
    if cfg.container.cmd then
      lsp_cmd = cfg.container.cmd[1]
    end
  end

  table.insert(cmd, container)
  table.insert(cmd, lsp_cmd)

  cfg.cmd = cmd

  vim.lsp.config(name .. "_remote", cfg)
  vim.lsp.enable(name .. "_remote")
end

vim.api.nvim_create_user_command("LspRemote", function(opts)
  local args = vim.split(opts.args, " ")
  local name = args[1]
  local container = args[2]

  stop_lsp(name)

  start_remote(name, container)
end, { desc = "Show detailed LSP status", nargs = "+" })
