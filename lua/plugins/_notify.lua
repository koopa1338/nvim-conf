local M = { "rcarriga/nvim-notify", event = "VeryLazy" }

M.config = function()
  L("notify", function(notify)
    notify.setup {
      stages = "slide",
      timeout = 1500,
      on_open = function(win)
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_set_config(win, { border = vim.g.border_type })
        end
      end,
    }
    vim.notify = notify
  end)
end

return M
