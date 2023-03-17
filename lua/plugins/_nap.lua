local M = {
  "liangxianzhe/nap.nvim",
}

M.config = function()
  L("nap", function(nap)
    nap.setup {
      next_prefix = "<M-n>",
      prev_prefix = "<M-p>",
      next_repeat = "<M-i>",
      prev_repeat = "<M-o>",
    }
    nap.nap("g", function()
      require("gitsigns").next_hunk { preview = true }
    end, function()
      require("gitsigns").prev_hunk { preview = true }
    end, "Next diff", "Previous diff")
  end)
end

return M
