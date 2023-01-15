local plugins = {
  { "folke/which-key.nvim" },
  { "mrjones2014/legendary.nvim" },

  { "axieax/urlview.nvim" },

  -- editing
  { "kylechui/nvim-surround" },
  { "numToStr/Comment.nvim" },
  { "numToStr/Comment.nvim" },
  { "nvim-treesitter/nvim-treesitter" },
  {
    "haringsrob/nvim_context_vt",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  { "folke/todo-comments.nvim" },
  -- Zen modes
  { "Pocco81/TrueZen.nvim" },

  -- movement and search
  { "markonm/traces.vim" },
  { "AckslD/messages.nvim" },
  { "nacro90/numb.nvim" },

  -- searching and file browsing
  { "nvim-lua/popup.nvim" },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "nvim-lua/telescope.nvim",
    branch = "0.1.x",
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = vim.fn.executable "make" == 1,
  },
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "LukasPietzschmann/telescope-tabs" },

  {
    "goolord/alpha-nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },

  { "dimfred/resize-mode.nvim" },

  -- text objects and motions
  { "wellle/targets.vim" },
  { "windwp/nvim-autopairs" },
  {
    "windwp/nvim-ts-autotag",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  { "godlygeek/tabular" },

  -- syntax and languages
  { "lervag/vimtex", ft = { "tex" } },
  {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
    },
  },
  { "L3MON4D3/LuaSnip", dependencies = { "nvim-cmp" } },
  { "rafamadriz/friendly-snippets" },
  { "michaelb/sniprun", build = "bash install.sh" },

  -- theme
  { "rktjmp/lush.nvim" },
  {
    "tjdevries/express_line.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  -- use {
  --   'glepnir/galaxyline.nvim',
  --   requires = { "kyazdani42/nvim-web-devicons", opt = true }
  -- }
  { "alvarosevilla95/luatab.nvim" },
  { "kyazdani42/nvim-web-devicons" },
  { "kyazdani42/nvim-tree.lua" },
  { "rcarriga/nvim-notify" },
  { "stevearc/dressing.nvim" },
  { "petertriho/nvim-scrollbar" },

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
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
  },

  -- debugger
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
    },
  },

  -- utils
  { "jghauser/mkdir.nvim" },
  { "gelguy/wilder.nvim" },
  { "romgrk/fzy-lua-native" },
  { "uga-rosa/ccc.nvim" }, -- color picker
}

local custom_plugins = L "plugins_custom"
for _, v in pairs(custom_plugins) do
  table.insert(plugins, v)
end

return plugins
