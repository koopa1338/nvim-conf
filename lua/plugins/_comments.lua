local M = {
  "numToStr/Comment.nvim",
  event = "BufReadPre",
  config = true,
}

M.opts = {
  mappings = {
    basic = true,
    extra = true,
  },
}

return M
