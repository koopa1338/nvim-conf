L("which-key", function(wk)
  wk.register({
    g = {
      name = "+git",
    },
  }, { prefix = "<leader>" })
end)

L("gitsigns", function(gitsigns)
  -- git signs
  gitsigns.setup {
    signs = {
      add = Get_sign_def "GitSignsLineColAdd",
      change = Get_sign_def "GitSignsLineColChange",
      delete = Get_sign_def "GitSignsLineColDelete",
      topdelete = Get_sign_def "GitSignsLineColTopdelete",
      changedelete = Get_sign_def "GitSignsLineColChangedelete",
      untracked = Get_sign_def "GitSignsLineColUntracked",
    },
    numhl = true,
    linehl = false,
    keymaps = {
      -- Default keymap options
      noremap = true,
      buffer = true,
    },
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
      internal = true, -- If luajit is present
    },
    preview_config = {
      border = vim.g.border_type,
    },
  }

  Map("n", "<leader>gB", function()
    gitsigns.blame_line { full = true }
  end, { silent = true })
  Map("n", "<leader>gb", gitsigns.toggle_current_line_blame, { silent = true })
  Map("n", "<leader>gd", gitsigns.preview_hunk, { silent = true })
  Map("n", "<leader>g-", gitsigns.undo_stage_hunk, { silent = true })
  Map("n", "<leader>g+", gitsigns.stage_hunk, { silent = true })
  Map("n", "<leader>gu", gitsigns.reset_hunk, { silent = true })

  L("which-key", function(wk)
    wk.register({
      g = {
        b = { "Toggle Current Line Blame" },
        d = { "Preview Hunk" },
        u = { "Reset Hunk" },
        B = { "Toggle Line Blame" },
        ["+"] = { "Stage Hunk" },
        ["-"] = { "Undo Stage Hunk" },
      },
    }, { prefix = "<leader>" })
  end)
end)

L("diffview", function(diffview)
  L("diffview.actions", function(actions)
    diffview.setup {
      diff_binaries = false, -- Show diffs for binaries
      enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
      use_icons = true, -- Requires nvim-web-devicons
      icons = { -- Only applies when use_icons is true.
        folder_closed = "???",
        folder_open = "???",
      },
      signs = {
        fold_closed = "???",
        fold_open = "???",
      },
      file_panel = {
        win_config = {
          position = "left",
          width = 40,
        },
        listing_style = "tree", -- One of 'list' or 'tree'
        tree_options = { -- Only applies when listing_style is 'tree'
          flatten_dirs = true, -- Flatten dirs that only contain one single dir
          folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
        },
      },
      file_history_panel = {
        win_config = {
          position = "bottom",
          height = 15,
        },
        log_options = {
          git = {
            single_file = {
              max_count = 512, -- Limit the number of commits
              follow = true, -- Follow renames (only for single file)
              all = false, -- Include all refs under 'refs/' including HEAD
              merges = false, -- List only merge commits
              no_merges = false, -- List no merge commits
              reverse = false, -- List commits in reverse order
            },
            multi_file = {
              max_count = 128, -- Limit the number of commits
              follow = false, -- Follow renames (only for single file)
              all = false, -- Include all refs under 'refs/' including HEAD
              merges = false, -- List only merge commits
              no_merges = false, -- List no merge commits
              reverse = false, -- List commits in reverse order
            },
          },
        },
      },
      default_args = { -- Default args prepended to the arg-list for the listed commands
        DiffviewOpen = {},
        DiffviewFileHistory = {},
      },
      hooks = {}, -- See ':h diffview-config-hooks'
      key_bindings = {
        disable_defaults = false, -- Disable the default key bindings
        -- The `view` bindings are active in the diff buffers, only when the current
        -- tabpage is a Diffview.
        panel = {},
        view = {
          ["<tab>"] = actions.select_next_entry, -- Open the diff for the next file
          ["<s-tab>"] = actions.select_prev_entry, -- Open the diff for the previous file
          ["gf"] = actions.goto_file, -- Open the file in a new split in previous tabpage
          ["<C-w><C-f>"] = actions.goto_file_split, -- Open the file in a new split
          ["<C-w>gf"] = actions.goto_file_tab, -- Open the file in a new tabpage
          ["<leader>e"] = actions.focus_files, -- Bring focus to the files panel
          ["<leader>b"] = actions.toggle_files, -- Toggle the files panel.
        },
        file_panel = {
          ["j"] = actions.next_entry, -- Bring the cursor to the next file entry
          ["<down>"] = actions.next_entry,
          ["k"] = actions.prev_entry, -- Bring the cursor to the previous file entry.
          ["<up>"] = actions.prev_entry,
          ["<cr>"] = actions.select_entry, -- Open the diff for the selected entry.
          ["o"] = actions.select_entry,
          ["<2-LeftMouse>"] = actions.select_entry,
          ["-"] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
          ["S"] = actions.stage_all, -- Stage all entries.
          ["U"] = actions.unstage_all, -- Unstage all entries.
          ["X"] = actions.restore_entry, -- Restore entry to the state on the left side.
          ["R"] = actions.refresh_files, -- Update stats and entries in the file list.
          ["<tab>"] = actions.select_next_entry,
          ["<s-tab>"] = actions.select_prev_entry,
          ["gf"] = actions.goto_file,
          ["<C-w><C-f>"] = actions.goto_file_split,
          ["<C-w>gf"] = actions.goto_file_tab,
          ["i"] = actions.listing_style, -- Toggle between 'list' and 'tree' views
          ["f"] = actions.toggle_flatten_dirs, -- Flatten empty subdirectories in tree listing style.
          ["<leader>e"] = actions.focus_files,
          ["<leader>b"] = actions.toggle_files,
        },
        file_history_panel = {
          ["g!"] = actions.options, -- Open the option panel
          ["<C-A-d>"] = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
          ["y"] = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
          ["zR"] = actions.open_all_folds,
          ["zM"] = actions.close_all_folds,
          ["j"] = actions.next_entry,
          ["k"] = actions.prev_entry,
          ["<cr>"] = actions.select_entry,
          ["o"] = actions.select_entry,
          ["<2-LeftMouse>"] = actions.select_entry,
          ["<tab>"] = actions.select_next_entry,
          ["<s-tab>"] = actions.select_prev_entry,
          ["gf"] = actions.goto_file,
          ["<C-w><C-f>"] = actions.goto_file_split,
          ["<C-w>gf"] = actions.goto_file_tab,
          ["<leader>e"] = actions.focus_files,
          ["<leader>b"] = actions.toggle_files,
        },
        option_panel = {
          ["<tab>"] = actions.select_entry,
          ["q"] = actions.close,
        },
      },
    }
  end)

  Map("n", "<Leader>gD", ":DiffviewOpen<CR>", { silent = true })
  Map("n", "<Leader>gH", ":DiffviewFileHistory<CR>", { silent = true })
  Map("n", "<Leader>gQ", ":DiffviewClose<CR>", { silent = true })

  L("which-key", function(wk)
    wk.register({
      g = {
        D = { "Show Diff View" },
        H = { "Show Diff History" },
        Q = { "Close Diffview" },
      },
    }, { prefix = "<leader>" })
  end)
end)

L("neogit", function(neogit)
  neogit.setup {
    disable_signs = false,
    disable_hint = true,
    disable_context_highlighting = false,
    disable_commit_confirmation = true,
    disable_insert_on_commit = false,
    auto_refresh = true,
    disable_builtin_notifications = true,
    use_magit_keybindings = false,
    commit_popup = {
      kind = "vsplit",
    },
    -- Change the default way of opening neogit
    kind = "tab",
    -- customize displayed signs
    signs = {
      -- { CLOSED, OPENED }
      section = { "???", "???" },
      item = { "???", "???" },
      hunk = { "", "" },
    },
    integrations = {
      diffview = true,
    },
    -- Setting any section to `false` will make the section not render at all
    sections = {
      untracked = {
        folded = false,
      },
      unstaged = {
        folded = false,
      },
      staged = {
        folded = false,
      },
      stashes = {
        folded = true,
      },
      unpulled = {
        folded = true,
      },
      unmerged = {
        folded = false,
      },
      recent = {
        folded = true,
      },
    },
    -- override/add mappings
    mappings = {
      -- modify status buffer mappings
      status = {
        -- Adds a mapping with "B" as key that does the "BranchPopup" command
        -- ["B"] = "BranchPopup",
      },
    },
  }

  Map("n", "<Leader>gs", ":Neogit<CR>", { silent = true })

  L("which-key", function(wk)
    wk.register({
      g = {
        s = { "Neogit" },
      },
    }, { prefix = "<leader>" })
  end)
end)
