L("messages", function(msg)
  -- TODO:
  -- * set custom filetype to map q to close
  -- * set buffer readonly
  msg.setup {
    prepare_buffer = function(opts)
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_option(buf, "filetype", "msgfloat")
      return vim.api.nvim_open_win(buf, true, opts)
    end,
  }

  L("messages.api", function(api)
    Msg = function(...)
      api.capture_thing(...)
    end
  end)
end)
