local M = {}
local sym = L("signs").debug_symbols

M.adapters = {
  lldb = {
    type = "executable",
    command = "codelldb",
    name = "lldb",
  },
}

M.configurations = {
  rust = {
    {
      name = "Debug",
      type = "lldb",
      request = "launch",
      program = function()
        local executables = {}
        local handle_output = function(_, data, _)
          if data then
            for _, line in ipairs(data) do
              local is_json, artifact = pcall(vim.fn.json_decode, line)

              if not is_json or type(artifact) ~= "table" or artifact.reason ~= "compiler-artifact" then
                goto loop_end
              end

              local is_binary = vim.list_contains(artifact.target.crate_types, "bin")
              local type
              if is_binary then
                type = sym.binary
              else
                type = sym.module
              end
              local is_build_script = vim.list_contains(artifact.target.kind, "custom-build")
              local is_test = artifact.profile.test
              if is_build_script then
                type = sym.build
              end
              if is_test then
                if not is_binary then
                  type = sym.module .. sym.test
                else
                  type = sym.test
                end
              end
              if (is_binary or not is_binary and is_test) and artifact.executable ~= vim.NIL then
                table.insert(executables, { type = type, path = artifact.executable })
              end

              ::loop_end::
            end
          end
        end

        return coroutine.create(function(dap_run_co)
          vim.fn.jobstart("cargo build --all-targets --message-format=json", {
            stdout_buffered = true,
            on_stdout = handle_output,
            on_exit = function(_, code)
              vim.schedule(function()
                if code ~= 0 then
                  vim.notify("cargo building all targets failed", vim.log.levels.ERROR, { title = "Build failed" })
                else
                  vim.ui.select(executables, {
                    prompt = "Select build artifact",
                    format_item = function(item)
                      return item.type .. " " .. item.path
                    end,
                  }, function(choice)
                    if choice then
                      coroutine.resume(dap_run_co, choice.path)
                    end
                  end)
                end
              end)
            end,
          })
        end)
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    },
  },
}

return M
