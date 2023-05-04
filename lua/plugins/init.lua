return {
  -- movement and search
  { "markonm/traces.vim", event = "BufReadPost" },

  -- text objects and motions
  { "wellle/targets.vim", event = "BufReadPost" },
  {
    "windwp/nvim-autopairs",
    config = true,
    event = "InsertEnter",
  },
  { "godlygeek/tabular", cmd = "Tabularize" },

  -- syntax and languages
  { "lervag/vimtex", ft = { "tex" } },
  {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = { "markdown" },
  },

  -- theme
  { "rktjmp/lush.nvim" },
  {
    "alvarosevilla95/luatab.nvim",
    config = function()
      L("luatab", function(luatab)
        luatab.setup {
          modified = function(bufnr)
            return vim.fn.getbufvar(bufnr, "&modified") == 1 and Get_sign_def("Modified").icon .. " " or ""
          end,
        }
      end)
    end,
    event = "BufReadPre",
  },
  { "kyazdani42/nvim-web-devicons" },
  {
    "petertriho/nvim-scrollbar",
    config = true,
    event = "BufReadPost",
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
    },
    cmd = {
      "DB",
      "DBUI",
      "DBUIToggle",
    },
  },

  -- utils
  { "romgrk/fzy-lua-native", event = "VeryLazy" },
  {
    -- color picker
    "uga-rosa/ccc.nvim",
    cmd = {
      "CccConvert",
      "CccHighlighterEnable",
      "CccHighlighterToggle",
      "CccPick",
    },
  },
  { "mbbill/undotree", cmd = "UndotreeToggle" },
  { "kevinhwang91/nvim-bqf", ft = { "qf" } },
}
