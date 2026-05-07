-- set font for gui mode
vim.opt.guifont = "Inconsolata Nerd Font Mono:h14"

Get_theme_hl = function(name)
  local hl = vim.api.nvim_get_hl(0, { name = name })
  for _, key in pairs { "foreground", "background", "special" } do
    if hl[key] then
      hl[key] = string.format("#%06x", hl[key])
    end
  end
  return hl
end

-- Defer loading the lush theme implementation until VimEnter so startup is faster.
local applied = false
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    if applied then
      return
    end
    applied = true
    local ok, impl = pcall(require, "walush_impl")
    if not ok or not impl or not impl.apply then
      vim.notify("walush: failed to load theme implementation", vim.log.levels.WARN)
      return
    end
    impl.apply()
  end,
})
