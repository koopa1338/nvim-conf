return {
  -- text objects and motions
  { "godlygeek/tabular", cmd = "Tabularize" },

  -- theme
  { "rktjmp/lush.nvim" },
  {
    "alvarosevilla95/luatab.nvim",
    config = function()
      L("luatab", function(luatab)
        luatab.setup {
          modified = function(bufnr)
            return vim.fn.getbufvar(bufnr, "&modified") == 1 and Get_sign_def("Modified").text .. " " or ""
          end,
        }
      end)
    end,
    event = { "TabEnter", "TabNew" },
  },
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  {
    "petertriho/nvim-scrollbar",
    config = true,
    event = "BufReadPost",
  },

  -- utils
  { "romgrk/fzy-lua-native", event = "VeryLazy" },
  {
    "sQVe/sort.nvim",
    config = true,
    event = "BufReadPost",
  },
  {
    -- color picker
    "uga-rosa/ccc.nvim",
    cmd = {
      "CccConvert",
      "CccHighlighterEnable",
      "CccHighlighterToggle",
      "CccPick",
    },
    config = function()
      L("ccc", function(ccc)
        ccc.setup {
          highlighter = {
            auto_enable = false,
            lsp = true,
          },
        }
      end)
    end,
  },
  { "mbbill/undotree", cmd = "UndotreeToggle" },
  {
    "nvzone/typr",
    cmd = "TyprStats",
    dependencies = "nvzone/volt",
    opts = {},
  },

  -- fun plugins
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
  },
}
