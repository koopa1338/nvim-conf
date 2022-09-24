local dap, dapui = L "dap", L "dapui"

if not dap or not dapui then
  return
end

Map("n", "<leader>Db", dap.toggle_breakpoint, { silent = true })
Map("n", "<leader>DB", function()
  dapui.float_element("breakpoints", { enter = true })
end, { silent = true })
Map("n", "<leader>Dc", function()
  vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
    dap.set_breakpoint(input)
  end)
end, { silent = true })
Map("n", "<leader>Dm", function()
  vim.ui.input({ prompt = "Log Point message: " }, function(input)
    dap.set_breakpoint(nil, nil, input)
  end)
end, { silent = true })

Map("n", "<M-d>", dap.continue, { silent = true })
Map("n", "<leader>Dp", dap.pause, { silent = true })

Map("n", "<leader>Ds", function()
  dapui.float_element("stacks", { enter = true })
end, { silent = true })
Map("n", "<leader>Dt", function()
  dapui.float_element("console", { enter = true })
end, { silent = true })

Map("n", "<leader>Do", dap.step_over, { silent = true })
Map("n", "<leader>Dg", dap.goto_, { silent = true })

Map("n", "<leader>Dl", dap.step_into, { silent = true })
Map("n", "<leader>Dh", dap.step_out, { silent = true })

Map("n", "<leader>Dk", dap.up, { silent = true })
Map("n", "<leader>Dj", dap.down, { silent = true })

Map("n", "<leader>Dr", dap.repl.toggle, { silent = true })
Map("n", "<leader>DD", dap.disconnect, { silent = true })

L("which-key", function(wk)
  wk.register({
    D = {
      name = "+Debug",
      b = { "Toggle Debug Breakpoint" },
      B = { "Show Debug Breakpoints" },
      c = { "Set Debug Breakpoint Condition" },
      m = { "Set Debug Log Point Message" },
      p = { "Pause Debugger" },
      s = { "Show Debug Stacks" },
      t = { "Show Debug Console" },
      o = { "Debug Step Over" },
      g = { "Debug GoTo" },
      l = { "Debug Step Into" },
      h = { "Debug Step Out" },
      k = { "Debug Step Up" },
      j = { "Debug Step Down" },
      r = { "Toggle Debug REPL" },
      D = { "Disconnect Debugger" },
      ["<M-d"] = { "Continue Debugger" },
    },
  }, { prefix = "<leader>" })
end)

-- TODO: setup configurations for debug options
-- dap.configuration.rust = {}

-- setting up debugger ui
dapui.setup {
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.5 },
        { id = "watches", size = 0.5 },
      },
      size = 50,
      position = "left",
    },
  },
}

-- open dapui when start debugging
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
  vim.opt.ls = 3
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
  vim.opt.ls = 2
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
  vim.opt.ls = 2
end


L("dap_custom", function(du)
  dap.adapters = du.adapters
  dap.configurations = du.configurations
end)
