local M = {
  "liangxianzhe/nap.nvim",
  config = true,
}

M.opts = {
  next_prefix = "<M-n>",
  prev_prefix = "<M-p>",
  next_repeat = "<M-i>",
  prev_repeat = "<M-o>",
  operator = {
    ["g"] = {
      next = {
        command = function()
          require("gitsigns").next_hunk { preview = true }
        end,
        desc = "Next diff",
      },
      prev = {
        command = function()
          require("gitsigns").prev_hunk { preview = true }
        end,
        desc = "Prev diff",
      },
    },
  },
}

return M
