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
        },
      },
      selection_strategy = "reset",
      sorting_strategy = "descending",
      scroll_strategy = "cycle",
      prompt_prefix = "🔎  ",
    },
    pickers = {
      fd = {
        theme = "ivy",
      },
      git_files = {
        theme = "ivy",
      },
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
      current_buffer_fuzzy_find = {
        previewer = false,
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_cursor {},

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

  L("urlview", function()
    telescope.load_extension "urlview"
  end)

  Map("n", "<leader>fg", ":Telescope git_files<CR>", { silent = true })
  Map("n", "<leader>ff", ":Telescope fd hidden=true<CR>", { silent = true })
  Map("n", "<leader>FF", ":Telescope fd hidden=true no_ignore=true<CR>", { silent = true })
  Map("n", "<leader>fr", ":Telescope live_grep<CR>", { silent = true })
  Map({ "v", "n" }, "<leader>f*", ":Telescope grep_string<CR>", { silent = true })
  Map("n", "<leader>fR", ":Telescope registers<CR>", { silent = true })
  Map("n", "<leader>bb", ":Telescope buffers<CR>", { silent = true })
  Map("n", "<leader>fb", ":Telescope current_buffer_fuzzy_find<CR>", { silent = true })
  Map("n", "<leader>fe", ":Telescope treesitter<CR>", { silent = true })
  Map("n", "<leader>fm", ":Telescope marks<CR>", { silent = true })

  -- lsp bindings
  Map("n", "<leader>ltd", ":Telescope diagnostics bufnr=0<CR>", { silent = true })
  Map("n", "<leader>ltD", ":Telescope diagnostics<CR>", { silent = true })

  Map("n", "<leader><leader>q", ":Telescope quickfix<CR>", { silent = true })
  Map("n", "<leader><leader>l", ":Telescope loclist<CR>", { silent = true })
  Map("n", "<leader><leader>n", ":Telescope notify<CR>", { silent = true })

  Map("n", "<leader><leader>M", ":Telescope man_pages<CR>", { silent = true })
  Map("n", "<leader><leader>K", ":Telescope keymaps<CR>", { silent = true })
  Map("n", "<leader><leader>H", ":Telescope help_tags<CR>", { silent = true })
  Map("n", "<leader><leader>T", ":Telescope resume<CR>", { silent = true })

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
