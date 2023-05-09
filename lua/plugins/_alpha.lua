local M = {
  "goolord/alpha-nvim",
  -- issue with wilder (padding and cursor move aucmd)
  -- https://github.com/goolord/alpha-nvim/issues/210
  commit = "89eaa18",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  event = "VimEnter",
}

M.config = function()
  local alpha = L "alpha"
  local dashboard = L "alpha.themes.dashboard"

  -- Set header
  ---@diagnostic disable: need-check-nil
  dashboard.section.header.val = {
    "   ⢕⢕⢕⢕⢕⠅⢗⢕⠕⣠⠄⣗⢕⢕⠕⢕⢕⢕⠕⢠⣿⠐⢕⢕⢕⠑⢕⢕⠵⢕    ",
    "   ⢕⢕⢕⢕⠁⢜⠕⢁⣴⣿⡇⢓⢕⢵⢐⢕⢕⠕⢁⣾⢿⣧⠑⢕⢕⠄⢑⢕⠅⢕    ",
    "   ⢕⢕⠵⢁⠔⢁⣤⣤⣶⣶⣶⡐⣕⢽⠐⢕⠕⣡⣾⣶⣶⣶⣤⡁⢓⢕⠄⢑⢅⢑    ",
    "   ⠍⣧⠄⣶⣾⣿⣿⣿⣿⣿⣿⣷⣔⢕⢄⢡⣾⣿⣿⣿⣿⣿⣿⣿⣦⡑⢕⢤⠱⢐    ",
    "   ⢠⢕⠅⣾⣿⠋⢿⣿⣿⣿⠉⣿⣿⣷⣦⣶⣽⣿⣿⠈⣿⣿⣿⣿⠏⢹⣷⣷⡅⢐    ",
    "   ⣔⢕⢥⢻⣿⡀⠈⠛⠛⠁⢠⣿⣿⣿⣿⣿⣿⣿⣿⡀⠈⠛⠛⠁⠄⣼⣿⣿⡇⢔    ",
    "   ⢕⢕⢽⢸⢟⢟⢖⢖⢤⣶⡟⢻⣿⡿⠻⣿⣿⡟⢀⣿⣦⢤⢤⢔⢞⢿⢿⣿⠁⢕    ",
    "   ⢕⢕⠅⣐⢕⢕⢕⢕⢕⣿⣿⡄⠛⢀⣦⠈⠛⢁⣼⣿⢗⢕⢕⢕⢕⢕⢕⡏⣘⢕    ",
    "   ⢕⢕⠅⢓⣕⣕⣕⣕⣵⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣷⣕⢕⢕⢕⢕⡵⢀⢕⢕    ",
    "   ⢑⢕⠃⡈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⢕⢕⢕    ",
  }
  -- Set menu
  dashboard.section.buttons.val = {
    dashboard.button("e", "  New file", "<cmd>enew<CR>"),
    dashboard.button("1", "ﮮ  Plugins", "<cmd>Lazy<CR>"),
    dashboard.button("2", "ﮮ  Update Treesitter", "<cmd>TSUpdate<CR>"),
    dashboard.button("3", "ﯟ  Mason", "<cmd>Mason<CR>"),
    dashboard.button("4", "✙  Check", "<cmd>checkhealth<CR>"),
    dashboard.button("q", "  Quit NVIM", "<cmd>qa<CR>"),
  }

  alpha.setup(dashboard.opts)
end

return M
