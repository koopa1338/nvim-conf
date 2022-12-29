L("resize-mode", function(rs)
  rs.setup({
    horizontal_amount = 5,
    vertical_amount = 5,
    quit_key = "<ESC>",
    enable_mapping = true,
    resize_keys = {
      "h", -- increase to the left
      "j", -- increase to the bottom
      "k", -- increase to the top
      "l", -- increase to the right
      "<M-h>", -- decrease to the left
      "<M-j>", -- decrease to the bottom
      "<M-k>", -- decrease to the top
      "<M-l>", -- decrease to the right
    },
  })

  Map("n", "<leader><leader>R", rs.start , { silent = true, desc = "Resize Mode" })
end)
