local M = {
  "liangxianzhe/nap.nvim",
  config = true,
  event = "VeryLazy",
}

M.opts = {
  next_prefix = "<M-n>",
  prev_prefix = "<M-p>",
  next_repeat = "<M-i>",
  prev_repeat = "<M-o>",
  operators = {
    ["g"] = {
      next = {
        command = function()
          L("gitsigns").next_hunk { preview = true }
        end,
        desc = "Next diff",
      },
      prev = {
        command = function()
          L("gitsigns").prev_hunk { preview = true }
        end,
        desc = "Prev diff",
      },
    },
    ["D"] = {
      next = { command = vim.diagnostic.goto_next, desc = "Next diagnostic" },
      prev = { command = vim.diagnostic.goto_prev, desc = "Prev diagnostic" },
      mode = { "n", "v", "o" },
    },
  },
}

return M
