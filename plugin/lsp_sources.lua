local M = {}

M.ls = nil

local cmd_available = function(cmd)
  return vim.fn.executable(cmd) == 1
end

M.get_null_ls_sources = function()
  local sources = {}
  if M.ls then
    local custom_sources = {}
    L("user_settings", function(settings)
      custom_sources = L("user_settings").lsp_sources(M.ls)
    end)
    for k, v in pairs(custom_sources) do
      if v.custom then
        local cond = v.config.condition
        if v.external_cmd and cond ~= nil then
          v.config.condition = cond and cmd_available(v.external_cmd)
        end
        M.ls.register(v.config)
      else
        local src = M.ls.builtins[v.type][k]
        if v.with then
          src = src.with(v.with)
        end
        if v.external_cmd then
          if cmd_available(k) then
            table.insert(sources, src)
          end
        else
          table.insert(sources, src)
        end
      end
    end
  end

  return sources
end

return M
