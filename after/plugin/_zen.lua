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

  Map("n", "<Leader>z", "<cmd>TZFocus<CR>", { silent = true, desc = "Maximize current Window" })
  Map("n", "<Leader>Z", "<cmd>TZAtaraxis<CR>", { silent = true, desc = "Focus Time" })

  L("which-key", function(wk)
    wk.register({
      z = { "Maximize current Window" },
      Z = { "Focus Time" },
    }, { prefix = "<leader>" })
  end)
end)
