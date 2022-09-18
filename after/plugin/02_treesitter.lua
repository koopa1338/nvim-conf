L("nvim-treesitter.configs", function(config)
  config.setup {
    auto_install = true,
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
    autotag = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>p"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>P"] = "@parameter.inner",
        },
      },
    },
  }
end)
