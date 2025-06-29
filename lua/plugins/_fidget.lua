return {
  "j-hui/fidget.nvim",
  event = "BufReadPre",
  opts = {
    notification = {
      window = {
        border = vim.g.border_type,
      },
    },
  },
}
