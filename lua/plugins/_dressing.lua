local M = {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  config = true,
}

M.opts = {
  input = {
    enabled = true,
    default_prompt = "➤ ",
    insert_only = false,
    relative = "cursor",
    border = vim.g.border_type,
    prefer_width = 50,
    min_width = 25,
    win_options = {
      winblend = 0,
    },
    override = function(conf)
      conf.row = 4
      conf.anchor = "SW"
      return conf
    end,
  },
  select = {
    enabled = true,
  },
}

return M
