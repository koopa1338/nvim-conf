local M = {
  "folke/which-key.nvim",
  cond = vim.g.whichkey,
  config = true,
}

M.opts = {
  plugins = {
    marks = false,
    registers = false,
  },
}

return M
