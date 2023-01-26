local M = { "stevearc/dressing.nvim", event = "VeryLazy" }

M.config = function()
  L("dressing", function(dressing)
    dressing.setup {
      input = {
        enabled = true,
        default_prompt = "➤ ",
        insert_only = false,
        anchor = "SW",
        relative = "cursor",
        border = vim.g.border_type,
        prefer_width = 50,
        min_width = 25,
        win_options = {
          winblend = 0,
        },
        override = function(conf)
          conf.row = 4
          return conf
        end,
      },
      select = {
        enabled = true,
      },
    }
  end)
end

return M
