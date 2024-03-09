local M = {
  "rcarriga/nvim-dap-ui",
  event = "BufReadPost",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
}

M.config = function()
  local dap = L "dap"
  local dapui = L "dapui"
  local signs = L("signs").signs
  -- setting up debugger ui
  ---@diagnostic disable: need-check-nil
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

  Map("n", "<M-d>b", dap.toggle_breakpoint, { silent = true, desc = "Toggle Debug Breakpoint" })
  Map(
    "n",
    "<M-d><M-l>",
    "<cmd>Telescope dap list_breakpoints layout_strategy=horizontal<CR>",
    { silent = true, desc = "Show Debug Breakpoints" }
  )
  Map("n", "<M-d>c", function()
    vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
      dap.set_breakpoint(input)
    end)
  end, { silent = true, desc = "Set Debug Breakpoint Condition" })
  Map("n", "<M-d>m", function()
    vim.ui.input({ prompt = "Log Point message: " }, function(input)
      dap.set_breakpoint(nil, nil, input)
    end)
  end, { silent = true, desc = "Set Debug Log Point Message" })

  Map("n", "<M-d>C", dap.clear_breakpoints, { silent = true, desc = "Clear All Breakpoints" })

  Map("n", "<M-d>s", function()
    if dap.session() then
      dap.terminate()
    else
      vim.cmd "Telescope dap configurations theme=dropdown layout_strategy=horizontal"
    end
  end, { silent = true, desc = "Start/Terminate Debugger Session" })
  Map("n", "<M-d>p", dap.pause, { silent = true, desc = "Pause Debugger" })

  Map("n", "<M-d>S", function()
    dapui.float_element("stacks", { enter = true })
  end, { silent = true, desc = "Show Debug Stacks" })
  Map("n", "<M-d>T", function()
    dapui.float_element("console", { enter = true })
  end, { silent = true, desc = "Show Debug Console" })

  Map("n", "<M-d>o", dap.step_over, { silent = true, desc = "Debug Step Over" })
  Map("n", "<M-d>;", dap.run_to_cursor, { silent = true, desc = "Debug GoTo" })

  Map("n", "<M-d>l", dap.step_into, { silent = true, desc = "Debug Step Into" })
  Map("n", "<M-d>h", dap.step_out, { silent = true, desc = "Debug Step Out" })

  Map("n", "<M-d>k", dap.up, { silent = true, desc = "Debug Step Up" })
  Map("n", "<M-d>j", dap.down, { silent = true, desc = "Debug Step Down" })

  Map("n", "<M-d>R", dap.repl.toggle, { silent = true, desc = "Toggle Debug REPL" })
  Map("n", "<M-d>Q", dap.disconnect, { silent = true, desc = "Disconnect Debugger" })
end

return M
