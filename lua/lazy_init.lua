local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local plugin_path = vim.fn.stdpath "config" .. "/plugin/"
if not package.path:find(plugin_path) then
  package.path = plugin_path .. "?.lua;" .. package.path
end
