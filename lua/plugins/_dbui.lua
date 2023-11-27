local M = {
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    require("dbee").install "go"
  end,
  cmd = {
    "DBUI",
  },
}

M.config = function()
  L("dbee", function(dbee)
    vim.api.nvim_create_user_command("DBUI", dbee.open, {})

    dbee.setup {
      drawer = {
        disable_help = true,
      },
      ui = {
        window_commands = {
          result = "bo 20split",
        },
      },
    }
  end)
end
return M
