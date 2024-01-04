return {
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
            return vim.fn.getbufvar(bufnr, "&modified") == 1 and Get_sign_def("Modified").text .. " " or ""
          end,
        }
      end)
    end,
    event = { "TabEnter", "TabNew" },
  },
  { "kyazdani42/nvim-web-devicons" },
  {
    "petertriho/nvim-scrollbar",
    config = true,
    event = "BufReadPost",
  },

  -- utils
  { "romgrk/fzy-lua-native", event = "VeryLazy" },
  { "sQVe/sort.nvim", config = true, event = "VeryLazy" },
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
}
