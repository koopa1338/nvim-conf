local fn, api = vim.fn, vim.api

-- Install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
  is_bootstrap = true
  fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  vim.cmd [[ packadd packer.nvim ]]
end

-- TODO:
-- rest-nvim for .http files (lazily loaded)
-- heirline, alternatively galaxyline
-- urlview.nvim
require("packer").startup {
  function(use)
    -- Packer
    use "wbthomason/packer.nvim"
    use "lewis6991/impatient.nvim"
    use "folke/which-key.nvim"
    use "mrjones2014/legendary.nvim"

    use "axieax/urlview.nvim"

    -- editing
    use "kylechui/nvim-surround"
    use "numToStr/Comment.nvim"
    use {
      "haringsrob/nvim_context_vt",
      requires = {
        "nvim-treesitter/nvim-treesitter",
      },
    }
    -- Zen modes
    use "Pocco81/TrueZen.nvim"

    -- movement and search
    use "markonm/traces.vim"
    use {
      "tpope/vim-scriptease",
      cmd = {
        "Messages", --view messages in quickfix list
        "Verbose", -- view verbose output in preview window.
      },
    }

    -- searching and file browsing
    use "nvim-lua/popup.nvim"
    use "nvim-treesitter/nvim-treesitter"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "nvim-lua/telescope.nvim"
    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      cond = fn.executable "make" == 1,
    }
    use { "nvim-telescope/telescope-ui-select.nvim" }

    use {
      "goolord/alpha-nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
    }

    -- text objects and motions
    use "wellle/targets.vim"
    use "windwp/nvim-autopairs"
    use "windwp/nvim-ts-autotag"
    use "godlygeek/tabular"

    -- syntax and languages
    use { "lervag/vimtex", ft = { "tex" } }
    use {
      "saecki/crates.nvim",
      event = "BufRead Cargo.toml",
      requires = { "nvim-lua/plenary.nvim" },
    }
    use "neovim/nvim-lspconfig"
    use "williamboman/mason.nvim"
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
    }
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind-nvim",
      },
    }
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"
    use { "michaelb/sniprun", run = "bash install.sh" }

    -- theme
    use "rktjmp/lush.nvim"
    use {
      "tjdevries/express_line.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
      },
    }
    -- use {
    --   'glepnir/galaxyline.nvim',
    --   requires = { "kyazdani42/nvim-web-devicons", opt = true }
    -- }
    use "alvarosevilla95/luatab.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "kyazdani42/nvim-tree.lua"
    use "rcarriga/nvim-notify"
    use "stevearc/dressing.nvim"

    -- version control
    use "junegunn/gv.vim"
    use {
      "lewis6991/gitsigns.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
      },
    }
    use {
      "TimUntersberger/neogit",
      requires = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
      },
    }

    -- debugger
    use {
      "rcarriga/nvim-dap-ui",
      requires = {
        "mfussenegger/nvim-dap",
      },
    }

    use {
      "kristijanhusak/vim-dadbod-ui",
      requires = {
        "tpope/vim-dadbod",
      },
    }

    if is_bootstrap then
      local packer = require "packer"
      packer.sync()
      packer.compile()
    end
  end,
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = fn.stdpath "config" .. "/lua/packer_compiled.lua",
  },
}

-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print "=================================="
  print "    Plugins are being installed"
  print "    Wait until Packer completes,"
  print "       then restart nvim"
  print "=================================="
  return true
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer = vim.api.nvim_create_augroup("Packer", { clear = true })
api.nvim_create_autocmd("BufWritePost", {
  group = packer,
  pattern = fn.expand "$MYVIMRC",
  command = "source <afile> | PackerCompile",
})

-- plugins with only default configurations or configs that has to be done before configure other plugins
require("nvim-autopairs").setup {}
require("luatab").setup {}

L("notify", function(notify)
  notify.setup { stages = "slide" }
  vim.notify = notify
end)

return is_bootstrap
