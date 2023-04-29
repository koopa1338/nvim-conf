return {
  { "mrjones2014/legendary.nvim", event = "VeryLazy" },

  -- movement and search
  { "markonm/traces.vim", event = "VeryLazy" },

  -- text objects and motions
  { "wellle/targets.vim", event = "VeryLazy" },
  {
    "windwp/nvim-autopairs",
    config = true,
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
        local signs = L("signs").signs
        luatab.setup {
          modified = function(bufnr)
            return vim.fn.getbufvar(bufnr, "&modified") == 1 and signs.Modified.icon .. " " or ""
          end,
        }
      end)
    end,
    event = "VeryLazy",
  },
  { "kyazdani42/nvim-web-devicons" },
  {
    "petertriho/nvim-scrollbar",
    config = true,
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    event = "VeryLazy",
    dependencies = {
      "tpope/vim-dadbod",
    },
  },

  -- utils
  { "gelguy/wilder.nvim", event = "VeryLazy" },
  { "romgrk/fzy-lua-native", event = "VeryLazy" },
  { "uga-rosa/ccc.nvim", event = "VeryLazy" }, -- color picker
  { "mbbill/undotree", cmd = "UndotreeToggle" },
}
