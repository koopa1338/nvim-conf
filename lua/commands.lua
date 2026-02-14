-- command abbreviations
vim.cmd [[cabbrev yfn   let @+ = expand("%:t")]]
vim.cmd [[cabbrev yfp   let @+ = expand("%:p")]]
vim.cmd [[cabbrev yrp   let @+ = expand("%")]]

-- commands
vim.api.nvim_create_user_command("XdgOpen", function()
  local file = vim.fn.expand("%:p")
  vim.fn.jobstart({ "xdg-open", file }, { detach = true })
end, {})

