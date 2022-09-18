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

  Map("n", "<Leader>z", ":TZFocus<CR>", { silent = true })
  Map("n", "<Leader>Z", ":TZAtaraxis<CR>", { silent = true })

  L("which-key", function(wk)
    wk.register({
      z = { "Focus Time" },
      Z = { "Focus Time++" },
    }, { prefix = "<leader>" })
  end)
end)
