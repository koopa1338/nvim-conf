local border_chars = function(border_type)
  local border_chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
  if border_type == "single" then
    border_chars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
  end
  if border_type == "double" then
    border_chars = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" }
  end
  return border_chars
end

L("telescope", function(telescope)
  local actions = require "telescope.actions"
  local previewers = require "telescope.previewers"
  local builtin = require "telescope.builtin"
  local themes = require "telescope.themes"

  local grep_selection = function()
    local start_table = vim.fn.getpos "."
    local end_table = vim.fn.getpos "v"
    local selection = {
      start_pos = {
        row = end_table[2] - 1,
        col = end_table[3] - 1,
      },
      end_pos = {
        row = start_table[2] - 1,
        col = start_table[3],
      },
    }

    if selection.start_pos.row ~= selection.end_pos.row then
      vim.notify(
        "Only single line selection are supported for live grep.",
        vim.log.levels.ERROR,
        { title = "Invalid selection" }
      )
      return
    end

    local start = selection[1]
    local last = selection[2]
    if selection.start_pos.col > selection.end_pos.col then
      start = selection[2]
      last = selection[1]
    end

    local search = vim.api.nvim_buf_get_text(0, start.row, start.col, last.row, last.col, {})

    if search then
      builtin.grep_string { search = search[1] }
      return
    end

    vim.notify("Search didn't had any result.", vim.log.levels.ERROR, { title = "Invalid selection" })
  end

  telescope.setup {
    defaults = {
      file_previewer = previewers.vim_buffer_cat.new,
      grep_previewer = previewers.vim_buffer_vimgrep.new,
      qflist_previewer = previewers.vim_buffer_qflist.new,
      layout_strategy = "flex",
      borderchars = border_chars(vim.g.border_type),
      layout_config = {
        prompt_position = "top",
        horizontal = {
          preview_width = 0.6,
        },
        vertical = {
          preview_height = 0.5,
        },
      },
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<M-q>"] = actions.smart_send_to_qflist,
          ["<C-M-q>"] = actions.smart_send_to_loclist,
        },
      },
      selection_strategy = "reset",
      sorting_strategy = "descending",
      scroll_strategy = "cycle",
      prompt_prefix = "🔎  ",
    },
    pickers = {
      marks = {
        theme = "ivy",
      },
      buffers = {
        theme = "ivy",
      },
      registers = {
        theme = "ivy",
      },
      quickfix = {
        layout_strategy = "vertical",
      },
      loclist = {
        layout_strategy = "vertical",
      },
      notify = {
        layout_strategy = "vertical",
      },
      man_pages = {
        layout_strategy = "vertical",
      },
    },
    extensions = {
      ["ui-input"] = {
        themes.get_cursor {},
      },
      ["ui-select"] = {
        themes.get_dropdown {
          layout_config = {
            height = 0.5,
          },
        },

        -- pseudo code / specification for writing custom displays, like the one
        -- for "codeactions"
        -- specific_opts = {
        --   [kind] = {
        --     make_indexed = function(items) -> indexed_items, width,
        --     make_displayer = function(widths) -> displayer
        --     make_display = function(displayer) -> function(e)
        --     make_ordinal = function(e) -> string
        --   },
        --   -- for example to disable the custom builtin "codeactions" display
        --      do the following
        --   codeactions = false,
        -- }
      },
    },
  }

  -- loading extensions
  telescope.load_extension "fzf"
  telescope.load_extension "notify"
  telescope.load_extension "ui-select"

  Map("n", "<leader>fg", "<cmd>Telescope git_files<CR>", { silent = true })
  Map("n", "<leader>ff", "<cmd>Telescope fd hidden=true<CR>", { silent = true })
  Map("n", "<leader>FF", "<cmd>Telescope fd hidden=true no_ignore=true<CR>", { silent = true })
  Map("n", "<leader>fr", "<cmd>Telescope live_grep<CR>", { silent = true })
  Map("n", "<leader>f*", "<cmd>Telescope grep_string<CR>", { silent = true })
  Map("v", "<leader>f*", grep_selection, { silent = true })
  Map("n", "<leader>fR", "<cmd>Telescope registers<CR>", { silent = true })
  Map("n", "<leader>bb", "<cmd>Telescope buffers<CR>", { silent = true })
  Map("n", "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { silent = true })
  Map("n", "<leader>fe", "<cmd>Telescope treesitter<CR>", { silent = true })
  Map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { silent = true })

  -- lsp bindings
  Map("n", "<leader>ltd", "<cmd>Telescope diagnostics bufnr=0<CR>", { silent = true })
  Map("n", "<leader>ltD", "<cmd>Telescope diagnostics<CR>", { silent = true })

  Map("n", "<leader><leader>q", "<cmd>Telescope quickfix<CR>", { silent = true })
  Map("n", "<leader><leader>l", "<cmd>Telescope loclist<CR>", { silent = true })
  Map("n", "<leader><leader>n", "<cmd>Telescope notify<CR>", { silent = true })

  Map("n", "<leader><leader>M", "<cmd>Telescope man_pages<CR>", { silent = true })
  Map("n", "<leader><leader>K", "<cmd>Telescope keymaps<CR>", { silent = true })
  Map("n", "<leader><leader>H", "<cmd>Telescope help_tags<CR>", { silent = true })
  Map("n", "<leader><leader>T", "<cmd>Telescope resume<CR>", { silent = true })

  L("which-key", function(wk)
    wk.register({
      b = {
        b = { "Show open Buffers" },
      },
      f = {
        name = "+finder",
        ["*"] = { "Grep String" },
        b = { "Fuzzy Find current Buffer" },
        e = { "Find Treesitter Symbols" },
        f = { "Find Files" },
        g = { "Find Git Files" },
        m = { "Find Marks" },
        r = { "Find Live Grep" },
        R = { "Find Registers" },
      },
      F = {
        name = "+finder",
        F = { "Find Files (Hidden + Ignored)" },
      },
      ["<leader>"] = {
        name = "+more",
        l = { "Show Location List" },
        n = { "Show Notifications" },
        q = { "Show Quickfix" },
        H = { "Show Help Tags" },
        K = { "Show Keymaps" },
        M = { "Show Man Pages" },
        T = { "Resume Last Finder" },
      },
    }, { prefix = "<leader>" })
  end)
end)

L("notify", function(notify)
  Map("n", "<leader><leader>N", notify.dismiss, { silent = true })

  L("which-key", function(wk)
    wk.register({
      ["<leader>"] = {
        N = { "Dismiss Notification" },
      },
    }, { prefix = "<leader>" })
  end)
end)
