return {
  { "mrjones2014/legendary.nvim", event = "VeryLazy" },

  -- movement and search
  { "markonm/traces.vim", event = "VeryLazy" },

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
        luatab.setup {}
      end)
    end,
    event = "VeryLazy",
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

  -- { "junegunn/gv.vim" },
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
