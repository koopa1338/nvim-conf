local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-lua/popup.nvim",
    "windwp/nvim-ts-autotag",
  },
  event = "VeryLazy",
}

M.config = function()
  L("nvim-treesitter.configs", function(config)
    config.setup {
      auto_install = true,
      -- installed by default: lua, query, vimdoc, vim, c, python, bash, markdown, markdown_inline
      ensure_installed = {
        "rust",
        "html",
        "css",
        "scss",
        "json",
        "typescript",
        "cpp",
        "cmake",
        "diff",
        "dockerfile",
        "toml",
        "make",
      },
      highlight = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          -- mappings for incremental selection (visual mappings)
          init_selection = "<M-w>", -- maps in normal mode to init the node/scope selection
          scope_incremental = "<M-w>", -- increment to the upper scope (as defined in locals.scm)
          node_incremental = "<M-n>", -- increment to the upper named parent
          node_decremental = "<M-p>", -- decrement to the previous node
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
  end)
end

return M
