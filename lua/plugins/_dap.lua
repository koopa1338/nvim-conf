local M = {
  "rcarriga/nvim-dap-ui",
  event = "BufReadPost",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    {
      "theHamsta/nvim-dap-virtual-text",
      config = true,
    },
  },
}

M.config = function()
  local signs = L("signs").signs
  -- setting up debugger ui
  L("dapui", function(dapui)
    dapui.setup {
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.4 },
            { id = "watches", size = 0.3 },
            { id = "stacks", size = 0.3 },
          },
          size = 0.25,
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

    Map("n", "<leader>df", function()
      vim.ui.select({ "Stacks", "Console", "Scopes", "Breakpoints" }, {
        prompt = "Select to open:",
      }, function(choice)
        local current = vim.api.nvim_get_current_win()
        local win_conf = vim.api.nvim_win_get_config(current)
        dapui.float_element(string.lower(choice), {
          width = math.floor(0.8 * win_conf.width),
          height = math.floor(0.8 * win_conf.height),
          enter = true,
        })
      end)
    end, { silent = true, desc = "Open dapui element in floag" })

    L("dap", function(dap)
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- load debugger adapters and configurations
      L("dap_settings", function(conf)
        dap.adapters = conf.adapters
        dap.configurations = conf.configurations
      end)

      Map("n", "<leader>dd", dap.toggle_breakpoint, { silent = true, desc = "Toggle Debug Breakpoint" })
      Map(
        "n",
        "<leader>d]",
        "<cmd>Telescope dap list_breakpoints layout_strategy=horizontal<CR>",
        { silent = true, desc = "Show Debug Breakpoints" }
      )
      Map("n", "<leader>di", function()
        vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
          dap.set_breakpoint(input)
        end)
      end, { silent = true, desc = "Set Debug Breakpoint Condition" })
      Map("n", "<leader>dm", function()
        vim.ui.input({ prompt = "Log Point message: " }, function(input)
          dap.set_breakpoint(nil, nil, input)
        end)
      end, { silent = true, desc = "Set Debug Log Point Message" })

      Map("n", "<leader>DD", dap.clear_breakpoints, { silent = true, desc = "Clear All Breakpoints" })

      Map("n", "<leader>?", function()
        dapui.eval(nil, { enter = true })
      end, { silent = true, desc = "Display value under cursor" })

      Map("n", "<leader>d>c", dap.run_to_cursor, { silent = true, desc = "Debug GoTo" })
      Map("n", "<leader>dj", dap.step_over, { silent = true, desc = "Debug Step Over" })

      Map("n", "<leader>dl", dap.step_into, { silent = true, desc = "Debug Step Into" })
      Map("n", "<leader>dk", dap.step_out, { silent = true, desc = "Debug Step Out" })

      Map("n", "<leader>dp", dap.pause, { silent = true, desc = "Pause Debugger" })

      Map("n", "<leader>dr", function()
        if dap.session() then
          vim.ui.select({ "Terminate", "Restart", "Disconnect" }, { prompt = "Session Actions" }, function(choice)
            if choice == "Terminate" then
              dap.terminate()
            elseif choice == "Restart" then
              dap.restart()
            elseif choice == "Disconnect" then
              dap.disconnect()
            else
              vim.notify("No valid session action selected", vim.log.levels.WARN, { title = "Error on session action" })
            end
          end)
        else
          vim.cmd "Telescope dap configurations theme=dropdown layout_strategy=horizontal"
        end
      end, { silent = true, desc = "Start/Terminate Debugger Session" })

      Map("n", "<M-d>k", dap.up, { silent = true, desc = "Debug Step Up" })
      Map("n", "<M-d>j", dap.down, { silent = true, desc = "Debug Step Down" })

      Map("n", "<M-d>r", dap.repl.toggle, { silent = true, desc = "Toggle Debug REPL" })
    end)
  end)
end

return M
