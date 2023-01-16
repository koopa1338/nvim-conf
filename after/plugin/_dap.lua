local dap, dapui = L "dap", L "dapui"

if not dap or not dapui then
  return
end

Map("n", "<leader>Db", dap.toggle_breakpoint, { silent = true, desc = "Toggle Debug Breakpoint" })
Map("n", "<leader>DB", function()
  dapui.float_element("breakpoints", { enter = true })
end, { silent = true, desc = "Show Debug Breakpoints" })
Map("n", "<leader>Dc", function()
  vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
    dap.set_breakpoint(input)
  end)
end, { silent = true, desc = "Set Debug Breakpoint Condition" })
Map("n", "<leader>Dm", function()
  vim.ui.input({ prompt = "Log Point message: " }, function(input)
    dap.set_breakpoint(nil, nil, input)
  end)
end, { silent = true, desc = "Set Debug Log Point Message" })

Map("n", "<leader>DQ", dap.clear_breakpoints, { silent = true, desc = "Clear All Breakpoints" })

Map("n", "<M-d>", function()
  if dap.session() then
    dap.terminate()
  else
    dap.continue()
  end
end, { silent = true, desc = "Start/Terminate Debugger Session" })
Map("n", "<leader>Dp", dap.pause, { silent = true, desc = "Pause Debugger" })

Map("n", "<leader>Ds", function()
  dapui.float_element("stacks", { enter = true })
end, { silent = true, desc = "Show Debug Stacks" })
Map("n", "<leader>Dt", function()
  dapui.float_element("console", { enter = true })
end, { silent = true, desc = "Show Debug Console" })

Map("n", "<leader>Do", dap.step_over, { silent = true, desc = "Debug Step Over" })
Map("n", "<leader>Dg", dap.run_to_cursor, { silent = true, desc = "Debug GoTo" })

Map("n", "<leader>Dl", dap.step_into, { silent = true, desc = "Debug Step Into" })
Map("n", "<leader>Dh", dap.step_out, { silent = true, desc = "Debug Step Out" })

Map("n", "<leader>Dk", dap.up, { silent = true, desc = "Debug Step Up" })
Map("n", "<leader>Dj", dap.down, { silent = true, desc = "Debug Step Down" })

Map("n", "<leader>Dr", dap.repl.toggle, { silent = true, desc = "Toggle Debug REPL" })
Map("n", "<leader>DD", dap.disconnect, { silent = true, desc = "Disconnect Debugger" })

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
      Q = { "Clear All Breakpoints"},
    },
    ["<M-d>"] = { "Start/Terminate Debugger Session" },
  }, { prefix = "<leader>" })
end)

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
    {
      elements = {
        "repl",
      },
      size = 0.2,
      position = "bottom",
    },
  },
  floating = {
    border = vim.g.border_type,
  },
}

-- open dapui when start debugging
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- load debugger adapters and configurations
L("dap_custom", function(du)
  dap.adapters = du.adapters
  dap.configurations = du.configurations
end)
