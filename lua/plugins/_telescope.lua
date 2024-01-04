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

local deps = {
  builtin = {},
  tabs = {},
}

local M = {}

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

  local start = selection["start_pos"]
  local last = selection["end_pos"]
  if selection.start_pos.col > selection.end_pos.col then
    local tmp = start
    start = last
    last = tmp
  end

  local search = vim.api.nvim_buf_get_text(0, start.row, start.col, last.row, last.col, {})

  if search then
    M.deps.builtin.grep_string { search = search[1] }
    return
  end

  vim.notify("Search didn't had any result.", vim.log.levels.ERROR, { title = "Invalid selection" })
end

local config = {
  "nvim-lua/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-ui-select.nvim",
    "LukasPietzschmann/telescope-tabs",
    "rcarriga/nvim-notify",
    "nvim-telescope/telescope-dap.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = vim.fn.executable "make" == 1,
    },
  },
  cmd = "Telescope",
  keys = {
    { "<leader>fg", "<cmd>Telescope git_files<CR>", silent = true, desc = "Find Git Files" },
    { "<leader>ff", "<cmd>Telescope fd hidden=true<CR>", silent = true, desc = "Find Files" },
    {
      "<leader>FF",
      "<cmd>Telescope fd hidden=true no_ignore=true<CR>",
      silent = true,
      desc = "Find Files (Hidden + Ignored)",
    },
    { "<leader>fr", "<cmd>Telescope live_grep<CR>", silent = true, desc = "Find Live Grep" },
    { "<leader>f*", "<cmd>Telescope grep_string<CR>", silent = true, desc = "Grep String" },
    {
      "<leader>f*",
      grep_selection,
      mode = "v",
      silent = true,
      desc = "Grep String (preselection)",
    },
    {
      "<leader>fG",
      function()
        vim.ui.input({
          prompt = "Grep over seachterm",
        }, function(input)
          if input ~= nil and input:len() > 0 then
            deps.builtin.grep_string { search = input }
          end
        end)
      end,
      silent = true,
      desc = "Grep String (input)",
    },
    {
      "<leader>fR",
      "<cmd>Telescope registers<CR>",
      silent = true,
      desc = "Find Registers",
    },
    {
      "<leader>bb",
      "<cmd>Telescope buffers<CR>",
      silent = true,
      desc = "Show open Buffers",
    },
    {
      "<leader>fb",
      "<cmd>Telescope current_buffer_fuzzy_find<CR>",
      silent = true,
      desc = "Fuzzy Find current Buffer",
    },
    {
      "<leader>fe",
      "<cmd>Telescope treesitter<CR>",
      silent = true,
      desc = "Find Treesitter Symbols",
    },
    { "<leader>fm", "<cmd>Telescope marks<CR>", silent = true, desc = "Find Marks" },

    -- lsp bindings
    {
      "<leader>ltd",
      "<cmd>Telescope diagnostics bufnr=0<CR>",
      silent = true,
      desc = "Show Local diagnostics",
    },
    {
      "<leader>ltD",
      "<cmd>Telescope diagnostics<CR>",
      silent = true,
      desc = "Show Global Diagnostics",
    },
    { "<leader><leader>Q", "<cmd>Telescope quickfix<CR>", silent = true, desc = "Show Quickfix" },
    {
      "<leader><leader>L",
      "<cmd>Telescope loclist<CR>",
      silent = true,
      desc = "Show Location List",
    },
    {
      "<leader><leader>n",
      "<cmd>Telescope notify<CR>",
      silent = true,
      desc = "Show Notifications",
    },
    {
      "<leader><leader>M",
      "<cmd>Telescope man_pages<CR>",
      silent = true,
      desc = "Show Man Pages",
    },
    { "<leader><leader>K", "<cmd>Telescope keymaps<CR>", silent = true, desc = "Show Keymaps" },
    {
      "<leader><leader>H",
      "<cmd>Telescope help_tags<CR>",
      silent = true,
      desc = "Show Help Tags",
    },
    {
      "<leader><leader>T",
      "<cmd>Telescope resume<CR>",
      silent = true,
      desc = "Resume Last Finder",
    },
    {
      "<leader><leader>N",
      function()
        if vim.notify then
          vim.notify.dismiss()
        end
      end,
      silent = true,
      desc = "Dismiss Notification",
    },
    {
      "<leader>ft",
      function()
        if deps.tabs then
          deps.tabs.list_tabs()
        end
      end,
      silent = true,
      desc = "Find Tabs",
    },
  },
}

for key, val in pairs(config) do
  if type(key) == "number" then
    table.insert(M, val)
  else
    M[key] = val
  end
end

M.config = function()
  L("telescope", function(telescope)
    deps.builtin = require "telescope.builtin"

    local actions = require "telescope.actions"
    local previewers = require "telescope.previewers"
    local themes = require "telescope.themes"

    telescope.setup {
      defaults = {
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        layout_strategy = "flex",
        borderchars = border_chars(vim.g.border_type),
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.6,
          },
          vertical = {
            prompt_position = "bottom",
            preview_height = 0.5,
          },
        },
        file_ignore_patterns = {
          ".git/",
          "node_modules/",
          ".cache",
          "%.o",
          "%.a",
          "%.out",
          "%.pdf",
          "%.mkv",
          "%.mp4",
          "%.zip",
          "%.jpg",
          "%.png",
          "%.bmp",
        },
        mappings = {
          i = {
            ["<C-R>"] = actions.cycle_history_next,
            ["<C-r>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-n>"] = actions.move_selection_better,
            ["<C-p>"] = actions.move_selection_worse,
            ["<c-u>"] = actions.preview_scrolling_up,
            ["<c-d>"] = actions.preview_scrolling_down,
            ["<c-b>"] = actions.results_scrolling_up,
            ["<c-f>"] = actions.results_scrolling_down,
            ["<C-a>"] = actions.toggle_all,
            ["<PageUp>"] = actions.preview_scrolling_up,
            ["<PageDown>"] = actions.preview_scrolling_down,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.smart_send_to_loclist + actions.open_loclist,
          },
        },
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        scroll_strategy = "cycle",
        prompt_prefix = " " .. Get_sign_def("Search").text,
        selection_caret = " " .. Get_sign_def("Selected").text .. "  ",
        entry_prefix = "     ",
        multi_icon = " " .. Get_sign_def("Multi_Select").text,
      },
      pickers = {
        marks = {
          theme = "ivy",
        },
        buffers = {
          sort_mru = true,
          ignore_current_buffer = true,
          theme = "ivy",
          mappings = {
            i = {
              ["<c-x>"] = "delete_buffer",
            },
          },
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
        },
      },
    }

    -- loading extensions
    telescope.load_extension "fzf"
    telescope.load_extension "notify"
    telescope.load_extension "ui-select"
    telescope.load_extension "dap"
    L("telescope-tabs", function(tt)
      deps.tabs = tt
      deps.tabs.setup()
    end)
  end)
end

return M
