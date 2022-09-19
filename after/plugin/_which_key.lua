L("which-key", function(wk)
  wk.setup {
    plugins = {
      marks = false,
      registers = false,
    },
  }

  wk.register({
    ["<leader>"] = {
      m = { "Show Messages In Quickfix" },
    },
  }, { prefix = "<leader>" })
end)
