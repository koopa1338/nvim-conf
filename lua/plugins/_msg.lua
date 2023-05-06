local M = { "AckslD/messages.nvim", cmd = "Messages" }

M.config = function()
  L("messages", function(msg)
    msg.setup {
      prepare_buffer = function(opts)
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(buf, "filetype", "msgfloat")
        return vim.api.nvim_open_win(buf, true, opts)
      end,
      buffer_opts = function(_)
        local win_height = vim.o.lines - vim.o.cmdheight - 2 -- Add margin for status and buffer line
        local win_width = vim.o.columns
        local height = math.floor(win_height * 0.9)
        local width = math.floor(win_width * 0.8)
        return {
          height = height,
          width = width,
          row = math.floor((win_height - height) / 2),
          col = math.floor((win_width - width) / 2),
          relative = "editor",
          style = "minimal",
          border = vim.g.border_type,
          zindex = 1,
        }
      end,
      post_open_float = function(_)
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_option(buf, "modifiable", false)
      end,
    }

    L("messages.api", function(api)
      Msg = function(...)
        api.capture_thing(...)
      end
    end)
  end)
end

return M
