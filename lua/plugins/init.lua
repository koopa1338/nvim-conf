return {
  { "mrjones2014/legendary.nvim", event = "VeryLazy" },

  -- movement and search
  { "markonm/traces.vim" },
  {
    "nacro90/numb.nvim",
    config = function()
      L("numb", function(numb)
        numb.setup()
      end)
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = vim.fn.executable "make" == 1,
    dependencies = {
      "nvim-lua/telescope.nvim",
    },
  },

  -- text objects and motions
  { "wellle/targets.vim", event = "VeryLazy" },
  {
    "windwp/nvim-autopairs",
    config = function()
      L("nvim-autopairs").setup()
    end,
  },
  { "godlygeek/tabular", event = "VeryLazy" },

  -- syntax and languages
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
  },
  { "lervag/vimtex", ft = { "tex" } },
  {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- theme
  { "rktjmp/lush.nvim" },
  {
    "alvarosevilla95/luatab.nvim",
    config = function()
      L("luatab", function(luatab)
        luatab.setup {}
      end)
    end,
  },
  { "kyazdani42/nvim-web-devicons" },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      L("scrollbar", function(scrollbar)
        scrollbar.setup()
      end)
    end,
  },

  -- version control
  { "junegunn/gv.vim" },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "TimUntersberger/neogit",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    event = "VeryLazy",
    dependencies = {
      "tpope/vim-dadbod",
    },
  },

  -- utils
  { "jghauser/mkdir.nvim", event = "VeryLazy" },
  { "gelguy/wilder.nvim", event = "VeryLazy" },
  { "romgrk/fzy-lua-native", event = "VeryLazy" },
  { "uga-rosa/ccc.nvim", event = "VeryLazy" }, -- color picker
}
