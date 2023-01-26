local M = { "kyazdani42/nvim-tree.lua" }

M.config = function()
  L("nvim-tree", function(tree)
    local signs = L("signs").signs

    local tree_cb = require("nvim-tree.config").nvim_tree_callback
    tree.setup {
      renderer = {
        highlight_git = true,
        icons = {
          webdev_colors = true,
          show = {
            file = true,
            folder = true,
            git = true,
          },
          glyphs = {
            git = {
              unstaged = signs.GitSignsLineColUnstaged.icon,
              staged = signs.GitSignsLineColAdd.icon,
              unmerged = signs.GitSignsLineColUnmerged.icon,
              untracked = signs.GitSignsLineColUntracked.icon,
            },
          },
        },
      },
      select_prompts = true,
      disable_netrw = true,
      open_on_setup = false,
      ignore_ft_on_setup = { "alpha" },
      open_on_tab = false,
      hijack_cursor = false,
      update_cwd = true,
      diagnostics = {
        enable = true,
        icons = {
          error = signs.DiagnosticSignError.icon,
          warning = signs.DiagnosticSignWarn.icon,
          info = signs.DiagnosticSignInfo.icon,
          hint = signs.DiagnosticSignHint.icon,
        },
      },
      update_focused_file = {
        enable = false,
        update_cwd = false,
        ignore_list = {},
      },
      filters = {
        dotfiles = true,
        custom = { ".git", "node_modules", ".cache" },
        exclude = {},
      },
      git = {
        enable = true,
        ignore = true,
        timeout = 400,
      },
      system_open = {
        cmd = nil,
        args = {},
      },
      view = {
        width = 40,
        side = "left",
        mappings = {
          custom_only = false,
          list = {
            { key = { "." }, cb = tree_cb "cd" },
            { key = { "c" }, cb = tree_cb "rename" },
            { key = { "y" }, cb = tree_cb "copy" },
            { key = { "gn" }, cb = tree_cb "next_git_item" },
            { key = { "gp" }, cb = tree_cb "prev_git_item" },
          },
        },
      },
    }

    Map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { silent = true, desc = "Toggle NvimTree" })

    L("which-key", function(wk)
      wk.register({
        ["<C-n>"] = { "Toggle NvimTree" },
      }, { prefix = "<leader>" })
    end)
  end)
end

return M
