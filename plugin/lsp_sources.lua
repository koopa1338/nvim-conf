local M = {}

M.ls = nil

local cmd_available = function(cmd)
  return vim.fn.executable(cmd) == 1
end

M.get_null_ls_sources = function()
  local sources = {}
  if M.ls then
    L("lsp_sources_custom", function(sources_custom)
      for k, v in pairs(sources_custom.get_custom_sources(M.ls)) do
        local src = nil
        if v.custom then
          local cond = v.config.condition
          if v.external_cmd and cond ~= nil then
            v.config.condition = cond and cmd_available(v.external_cmd)
          end
          M.ls.register(v.config)
        else
          src = M.ls.builtins[v.type][k]
        end

        if src then
          if v.external_cmd then
            if cmd_available(k) then
              table.insert(sources, src)
            end
          else
            table.insert(sources, src)
          end
        end
      end
    end)
  end

  return sources
end

return M