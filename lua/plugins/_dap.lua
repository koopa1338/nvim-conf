local M = {
  "rcarriga/nvim-dap-ui",
  event = "VeryLazy",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
}

M.config = function()
  local dap = L "dap"
  local dapui = L "dapui"
  local signs = L("signs").signs
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
    icons = {
      expanded = signs.FoldOpen.icon,
      collapsed = signs.FoldClosed.icon,
      current_frame = signs.DapCurrentFrame.icon,
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
  L("user_settings", function(settings)
    dap.adapters = settings.dap.adapters
    dap.configurations = settings.dap.configurations
  end)

  Map("n", "<leader>gdb", dap.toggle_breakpoint, { silent = true, desc = "Toggle Debug Breakpoint" })
  Map("n", "<leader>gds", function()
    dapui.float_element("breakpoints", { enter = true })
  end, { silent = true, desc = "Show Debug Breakpoints" })
  Map("n", "<leader>gdc", function()
    vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
      dap.set_breakpoint(input)
    end)
  end, { silent = true, desc = "Set Debug Breakpoint Condition" })
  Map("n", "<leader>gdm", function()
    vim.ui.input({ prompt = "Log Point message: " }, function(input)
      dap.set_breakpoint(nil, nil, input)
    end)
  end, { silent = true, desc = "Set Debug Log Point Message" })

  Map("n", "<leader>gdD", dap.clear_breakpoints, { silent = true, desc = "Clear All Breakpoints" })

  Map("n", "<M-d>", function()
    if dap.session() then
      dap.terminate()
    else
      dap.continue()
    end
  end, { silent = true, desc = "Start/Terminate Debugger Session" })
  Map("n", "<leader>gdp", dap.pause, { silent = true, desc = "Pause Debugger" })

  Map("n", "<leader>gdS", function()
    dapui.float_element("stacks", { enter = true })
  end, { silent = true, desc = "Show Debug Stacks" })
  Map("n", "<leader>gdT", function()
    dapui.float_element("console", { enter = true })
  end, { silent = true, desc = "Show Debug Console" })

  Map("n", "<leader>gdo", dap.step_over, { silent = true, desc = "Debug Step Over" })
  Map("n", "<leader>gd.", dap.run_to_cursor, { silent = true, desc = "Debug GoTo" })

  Map("n", "<leader>gdl", dap.step_into, { silent = true, desc = "Debug Step Into" })
  Map("n", "<leader>gdh", dap.step_out, { silent = true, desc = "Debug Step Out" })

  Map("n", "<leader>gdk", dap.up, { silent = true, desc = "Debug Step Up" })
  Map("n", "<leader>gdj", dap.down, { silent = true, desc = "Debug Step Down" })

  Map("n", "<leader>gdR", dap.repl.toggle, { silent = true, desc = "Toggle Debug REPL" })
  Map("n", "<leader>gdQ", dap.disconnect, { silent = true, desc = "Disconnect Debugger" })

  L("which-key", function(wk)
    wk.register {
      ["<leader>"] = {
        ["gd"] = {
          name = "+Debug",
          b = { "Toggle Debug Breakpoint" },
          s = { "Show Debug Breakpoints" },
          c = { "Set Debug Breakpoint Condition" },
          m = { "Set Debug Log Point Message" },
          p = { "Pause Debugger" },
          S = { "Show Debug Stacks" },
          T = { "Show Debug Console" },
          o = { "Debug Step Over" },
          ["."] = { "Debug GoTo" },
          l = { "Debug Step Into" },
          h = { "Debug Step Out" },
          k = { "Debug Step Up" },
          j = { "Debug Step Down" },
          R = { "Toggle Debug REPL" },
          Q = { "Disconnect Debugger" },
          D = { "Clear All Breakpoints" },
        },
      },
      ["<M-d>"] = { "Start/Terminate Debugger Session" },
    }
  end)
end

return M
