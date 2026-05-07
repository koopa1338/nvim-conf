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
  -- Accept nil opts and preserve any provided options.
  -- Default sensible values for commonly used boolean fields but keep any
  -- additional keys the caller may pass (like `buffer`, `desc`, `silent`, etc).
  opts = opts or {}
  if opts.silent == nil then
    opts.silent = false
  end
  if opts.remap == nil then
    opts.remap = false
  end
  if opts.expr == nil then
    opts.expr = false
  end

  -- Pass the options straight through to vim.keymap.set; this avoids
  -- accidentally dropping supported options when new ones are added.
  vim.keymap.set(mode, lhs, rhs, opts)
end

P = function(arg)
  print(vim.inspect(arg))

  return arg
end

L = function(module, callback)
  -- Try to require the module once. If successful, call callback(module)
  -- or return the module. Avoid requiring twice and handle errors cleanly.
  local ok, loaded = pcall(require, module)
  if not ok then
    -- Failure to load is silent here (preserving previous behaviour).
    -- If you want noisy behaviour in development, add vim.notify here.
    return nil
  end
  if callback then
    callback(loaded)
    return nil
  end
  return loaded
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
