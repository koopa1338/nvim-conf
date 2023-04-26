local M = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "haringsrob/nvim_context_vt",
    "nvim-lua/popup.nvim",
    "windwp/nvim-ts-autotag",
  },
}

M.config = function()
  L("nvim-treesitter.configs", function(config)
    config.setup {
      auto_install = true,
      ensure_installed = {
        "lua",
        "rust",
        "html",
        "css",
        "scss",
        "json",
        "typescript",
        "c",
        "cpp",
        "cmake",
        "diff",
        "dockerfile",
        "python",
        "toml",
        "make",
        "markdown",
      },
      highlight = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = { -- mappings for incremental selection (visual mappings)
          init_selection = "<M-w>", -- maps in normal mode to init the node/scope selection
          scope_incremental = "<M-w>", -- increment to the upper scope (as defined in locals.scm)
          node_incremental = "<M-n>", -- increment to the upper named parent
          node_decremental = "<M-d>", -- decrement to the previous node
        },
      },
      indent = { enable = true },
      refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = true },
      },
      autotags = {
        enable = true,
      },
      textobjects = {
        lsp_interop = {
          enable = true,
          border = vim.g.border_type,
          peek_definition_code = {
            ["<leader>pf"] = "@function.outer",
            ["<leader>pc"] = "@class.outer",
            ["<leader>ps"] = "@block.outer",
          },
        },
        "none",
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = { query = "@function.outer", desc = "Around function" },
            ["if"] = { query = "@function.inner", desc = "Inside function" },
            ["ac"] = { query = "@class.outer", desc = "Around class" },
            ["ic"] = { query = "@class.inner", desc = "Inside class" },
            ["as"] = { query = "@block.outer", desc = "Around scope" },
            ["is"] = { query = "@block.inner", desc = "Inside scope" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<M-s>"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader><M-s>"] = "@parameter.inner",
          },
        },
      },
    }

    L("which-key", function(wk)
      wk.register {
        ["<leader>"] = {
          p = {
            name = "+peek",
            f = { "Peek outer function" },
            c = { "Peek outer class" },
            s = { "Peek outer scope" },
          },
          ["<M-s>"] = { "Swap with previous parameter" },
        },
        ["<M-s>"] = { "Swap with next parameter" },
      }
    end)
  end)
end

return M
