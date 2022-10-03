L("messages", function(msg)
  -- TODO:
  -- * set custom filetype to map q to close
  -- * set buffer readonly
  msg.setup {}

  L("messages.api", function(api)
    Msg = function(...)
      api.capture_thing(...)
    end
  end)
end)
