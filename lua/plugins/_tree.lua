local fg = Colors_or_default().fg

local M = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      "s1n7ax/nvim-window-picker",
      config = function()
        require("window-picker").setup {
          autoselect_one = true,
          include_current = false,
          filter_rules = {
            bo = {
              filetype = { "neo-tree", "neo-tree-popup", "notify", "mason" },
              buftype = { "terminal", "quickfix" },
            },
          },
          -- TODO: PR for makeing highlightgroups work
          other_win_hl_color = fg or "#cccccc",
        }
      end,
    },
  },
}

M.config = function()
  L("neo-tree", function(tree)
    local signs = L("signs").signs
    tree.setup {
      close_if_last_window = true,
      popup_border_style = vim.g.border_type,
      use_popups_for_input = false,
      enable_git_status = true,
      enable_diagnostics = true,
      sort_case_insensitive = false,
      sort_function = nil,
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 1, -- extra padding on left hand side
          -- indent guides
          with_markers = false,
          highlight = "NeoTreeIndentMarker",
          with_expanders = nil,
          expander_collapsed = signs.FoldClosed.icon,
          expander_expanded = signs.FoldOpen.icon,
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = signs.FolderClosed.icon,
          folder_open = signs.FolderOpen.icon,
          folder_empty = signs.FolderEmpty.icon,
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = signs.File.icon,
          highlight = signs.File.hl,
        },
        modified = {
          symbol = signs.Modified.icon,
          highlight = signs.Modified.hl,
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = "NeoTreeFileName",
        },
        git_status = {
          symbols = {
            -- Change type
            added = signs.GitSignsLineColAdd.icon,
            modified = signs.GitSignsLineColChange.icon,
            deleted = signs.GitSignsLineColDelete.icon,
            renamed = signs.GitSignsRename.icon,
            untracked = signs.GitSignsLineColUntracked.icon,
            ignored = signs.GitSignsIgnored.icon,
            unstaged = signs.GitSignsLineColUntracked.icon,
            staged = signs.GitSignsStaged.icon,
            conflict = signs.GitSignsConflict.icon,
          },
        },
      },
      window = {
        position = "left",
        width = 40,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["<space>"] = {
            "toggle_node",
            nowait = false,
          },
          ["<2-LeftMouse>"] = "open",
          ["<cr>"] = "open",
          ["o"] = "open_with_window_picker",
          ["<esc>"] = "revert_preview",
          ["P"] = { "toggle_preview", config = { use_float = true } },
          ["l"] = "focus_preview",
          ["S"] = "open_split",
          ["s"] = "open_vsplit",
          ["<C-x>"] = "split_with_window_picker",
          ["<C-v>"] = "vsplit_with_window_picker",
          ["t"] = "open_tabnew",
          ["C"] = "close_node",
          ["z"] = "close_all_nodes",
          ["a"] = {
            "add",
            config = {
              show_path = "none",
            },
          },
          ["A"] = "add_directory",
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["m"] = "move",
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
        },
      },
      nesting_rules = {},
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_hidden = true,
          hide_by_name = {
            "node_modules",
            ".cache",
          },
        },
        follow_current_file = true,
        group_empty_dirs = false,
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = false,
        window = {
          mappings = {
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
            ["D"] = "noop",
            ["/"] = "fuzzy_finder_directory",
          },
        },
      },
      buffers = {
        follow_current_file = true,
        group_empty_dirs = true,
        show_unloaded = true,
        window = {
          mappings = {
            ["bd"] = "buffer_delete",
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
          },
        },
      },
    }
    Map("n", "<C-n>", "<cmd>NeoTreeRevealToggle<CR>", { silent = true, desc = "Toggle Neo Tree" })
    Map("n", "<M-C-n>", "<cmd>NeoTreeFloatToggle<CR>", { silent = true, desc = "Toggle Neo Tree Floating Mode" })

    L("which-key", function(wk)
      wk.register({
        ["<C-n>"] = { "Toggle NvimTree" },
        ["<M-C-n>"] = { "Toggle NvimTree Floating Mode" },
      }, { prefix = "<leader>" })
    end)
  end)
end

return M
