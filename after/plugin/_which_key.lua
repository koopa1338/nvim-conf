L("which-key", function(wk)
  wk.register({
    D = { "Diagnostic Trouble" },
    ["<leader>"] = {
      m = { "Show Messages In Quickfix" },
    },
  }, { prefix = "<leader>" })
end)
