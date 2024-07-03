return {
  ui = {
    border = vim.g.border_type,
  },
  diff = {
    cmd = "diffview.nvim",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tutor",
      },
    },
  },
}
