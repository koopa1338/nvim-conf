--- Key mapping
--- @mode: string | table<string>
--- @lhs: string
--- @rhs: string | lua function
--- @opts: table
---  remap: bool
---  silent: bool
---  expr: bool
---  buffer: bool
---  desc: string
Map = function(mode, lhs, rhs, opts)
  local opts_or_defaults = {
    remap = opts.remap or false,
    silent = opts.silent or false,
    expr = opts.expr or false,
    buffer = opts.buffer or false,
    desc = opts.desc,
  }
  if opts.buffer then
    opts_or_defaults["buffer"] = opts.buffer
  end

  vim.keymap.set(mode, lhs, rhs, opts_or_defaults)
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

R = function()
  vim.notify("Dependency plenary is missing.", vim.log.levels.WARN, { title = "Missing Dependency" })
end

L("plenary.reload", function(reloader)
  R = function(name)
    reloader.reload_module(name)
    vim.notify("Reloaded module " .. name .. ".", vim.log.levels.INFO, { title = "Success" })

    return require(name)
  end
end)

function table.clone(orig, seen)
  seen = seen or {}
  if orig == nil then
    return nil
  end
  if seen[orig] then
    return seen[orig]
  end

  local no
  if type(orig) == "table" then
    no = {}
    seen[orig] = no

    for k, v in next, orig, nil do
      no[table.clone(k, seen)] = table.clone(v, seen)
    end
    setmetatable(no, table.clone(getmetatable(orig), seen))
  else -- number, string, boolean, etc
    no = orig
  end
  return no
end

Colors_or_default = function()
  return L "colors"
    or {
      bg = "#0c0b1e",
      fg = "#d4ddff",
      color0 = "#0c0b1e",
      color1 = "#AE3F45",
      color2 = "#384773",
      color3 = "#E6AF61",
      color4 = "#184E93",
      color5 = "#A15359",
      color6 = "#245A9B",
      color7 = "#9ea5c0",
      color8 = "#1a1743",
      color9 = "#f1424b",
      color10 = "#3d56a0",
      color11 = "#ffe768",
      color12 = "#1364ca",
      color13 = "#e15c66",
      color14 = "#2273d6",
      color15 = "#d4ddff",
    }
end
