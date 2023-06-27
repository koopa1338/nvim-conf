local M = {
  "Pocco81/TrueZen.nvim",
  cmd = {
    "TZFocus",
    "TZAtaraxis",
  },
  keys = {
    { "<leader>z", "<cmd>TZFocus<CR>", silent = true, desc = "Maximize current Window" },
    { "<leader>Z", "<cmd>TZAtaraxis<CR>", silent = true, desc = "Focus Time" },
  },
}

M.config = function()
  L("true-zen", function(zen)
    zen.setup {
      modes = {
        ataraxis = {
          left_padding = 15,
          right_padding = 15,
          top_padding = 3,
          bottom_padding = 3,
          auto_padding = false,
          ideal_writing_area_width = { 0 },
        },
      },
    }
  end)
end

return M
