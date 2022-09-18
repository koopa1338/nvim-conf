L("dressing", function(dressing)
  dressing.setup {
    input = {
      enabled = true,
      default_prompt = "➤ ",
      insert_only = false,
      anchor = "SW",
      relative = "cursor",
      border = "rounded",
      prefer_width = 50,
      min_width = 25,
      winblend = 0,
      override = function(conf)
        conf.row = 4
        return conf
      end,
    },
    select = {
      enabled = false,
    },
  }
end)
