local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
}

M.config = function()
  local signs = L("signs").signs
  L("gitsigns", function(gitsigns)
    gitsigns.setup {
      signs = {
        add = { text = signs.GitSignsLineColAdd.icon },
        change = { text = signs.GitSignsLineColChange.icon },
        delete = { text = signs.GitSignsLineColDelete.icon },
        topdelete = { text = signs.GitSignsLineColTopdelete.icon },
        changedelete = { text = signs.GitSignsLineColChangedelete.icon },
        untracked = { text = signs.GitSignsLineColUntracked.icon },
      },
      numhl = true,
      linehl = false,
      watch_gitdir = {
        interval = 1000,
      },
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 350,
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      diff_opts = {
        internal = true,      -- If luajit is present
      },
      preview_config = {
        border = vim.g.border_type,
      },
    }

    Map("n", "<leader>gb", function()
      gitsigns.blame_line { full = true }
    end, { silent = true })
    Map("n", "<leader>gib", gitsigns.toggle_current_line_blame, { silent = true })
    Map("n", "<leader>gid", gitsigns.preview_hunk, { silent = true })
    Map("n", "<leader>g-", gitsigns.undo_stage_hunk, { silent = true })
    Map("n", "<leader>g+", gitsigns.stage_hunk, { silent = true })
    Map("n", "<leader>gu", gitsigns.reset_hunk, { silent = true })
  end)
end

return M
