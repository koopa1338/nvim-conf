-- Key mapping
Map = function(mode, lhs, rhs, opts)
  local opts_or_defaults = {
    remap = opts.remap or false,
    silent = opts.silent or false,
    expr = opts.expr or false,
  }
  if opts.buffer then
    opts_or_defaults["buffer"] = opts.buffer
  end

  vim.keymap.set(mode, lhs, rhs, opts_or_defaults)
end

UnMap = function(mode, lhs, opts)
  vim.keymap.del(mode, lhs, opts)
end
Contains = function(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

P = function(arg)
  print(vim.inspect(arg))
  return arg
end

L = function(module, callback)
  if pcall(require, module) then
    local loaded_mod = require(module)
    if callback then
      callback(loaded_mod)
    else
      return require(module)
    end
  end
  return nil
end

if not L "plenary" then
  return
end

local reloader = require "plenary.reload"
R = function(name)
  reloader.reload_module(name)
  return require(name)
end

Get_theme_hl = function(name)
  local hl_group = {}
  L("lush", function(lush)
    L("after.plugin.01_walush", function(walush)
      local tmp = walush[name]
      if tmp then
        for _, key in pairs { "fg", "bg" } do
          local value = tmp[key]
          if value ~= nil and value ~= "NONE" then
            hl_group[key] = lush.hsl(value.h, value.s, value.l).hex
          else
            hl_group[key] = value
          end
        end
        hl_group["gui"] = tmp["gui"]
      end
    end)
  end)

  return hl_group
end
