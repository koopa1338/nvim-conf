local M = {
  "echasnovski/mini.nvim",
  event = "VimEnter",
}

M.config = function()
  L("mini.pairs", function(mp)
    mp.setup()
  end)

  L("mini.ai", function(ai)
    local spec_treesitter = ai.gen_spec.treesitter
    ai.setup {
      custom_textobjects = {
        f = spec_treesitter { a = "@function.outer", i = "@function.inner" },
        c = spec_treesitter { a = "@class.outer", i = "@class.inner" },
        s = spec_treesitter { a = "@block.outer", i = "@block.inner" },
      },
      n_lines = 500,
      search_method = "cover",
      silent = true,
    }
  end)

  L("mini.surround", function(surround)
    surround.setup {
      mappings = {
        add = "<leader>sa",
        delete = "<leader>sd",
        find = "<leader>sf",
        find_left = "<leader>sF",
        highlight = "<leader>sh",
        replace = "<leader>sr",
        update_n_lines = "<leader>sn",
        suffix_last = "l",
        suffix_next = "n",
      },
      n_lines = 500,
    }
  end)

  L("mini.bracketed", function(bracketed)
    bracketed.setup()
  end)

  L("mini.comment", function(comment)
    comment.setup()
  end)

  L("mini.statusline", function(sl)
    sl.setup {
      content = {
        active = function()
          local mode, mode_hl = sl.section_mode { trunc_width = 120 }
          local git = sl.section_git { trunc_width = 40 }
          local diagnostics = sl.section_diagnostics { trunc_width = 75 }
          local filename = sl.section_filename { trunc_width = 140 }
          local fileinfo = sl.section_fileinfo { trunc_width = 120 }
          local location = sl.section_location { trunc_width = 75 }

          ------------------------------------------------------------------
          -- 🔥 Accurate visual selection counter
          ------------------------------------------------------------------
          local visual_count = ""
          local current_mode = vim.fn.mode()

          if current_mode == "v" or current_mode == "V" or current_mode == "\22" then
            local start_pos = vim.fn.getpos "v"
            local end_pos = vim.fn.getpos "."

            local s_row, s_col = start_pos[2], start_pos[3]
            local e_row, e_col = end_pos[2], end_pos[3]

            -- Normalize selection direction
            if s_row > e_row or (s_row == e_row and s_col > e_col) then
              s_row, e_row = e_row, s_row
              s_col, e_col = e_col, s_col
            end

            if current_mode == "V" then
              -- Line-wise visual mode
              visual_count = string.format(" %dL", e_row - s_row + 1)
            elseif current_mode == "v" then
              -- Character-wise visual mode (true multi-line count)
              local lines = vim.api.nvim_buf_get_lines(0, s_row - 1, e_row, false)

              if #lines == 1 then
                visual_count = string.format(" %dC", vim.fn.strchars(lines[1]:sub(s_col, e_col)))
              else
                local count = 0

                -- First line (from start column to end)
                count = count + vim.fn.strchars(lines[1]:sub(s_col))

                -- Middle lines
                for i = 2, #lines - 1 do
                  count = count + vim.fn.strchars(lines[i])
                end

                -- Last line (from beginning to end column)
                count = count + vim.fn.strchars(lines[#lines]:sub(1, e_col))

                visual_count = string.format(" %dC", count)
              end
            elseif current_mode == "\22" then
              -- Block-wise visual mode
              local height = e_row - s_row + 1
              local width = math.abs(e_col - s_col) + 1
              visual_count = string.format(" %d×%d", height, width)
            end
          end

          ------------------------------------------------------------------

          return sl.combine_groups {
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
            "%<",
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=",
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = mode_hl, strings = { visual_count, location } },
          }
        end,
      },
    }
  end)
end

return M
