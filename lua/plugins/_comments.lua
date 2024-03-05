local M = {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  config = true,
}

M.opts = {
  mappings = {
    basic = true,
    extra = true,
  },
}

return M
