return {
  {
    "stevearc/oil.nvim",
    keys = {
      { "<C-n>", "<CMD>Oil --float<CR>", mode = { "n" }, desc = "File explorer" },
    },
    config = {
      float = {
        max_width = 0.75,
        max_height = 0.75,
        border = vim.g.border_type,
        override = function(conf)
          conf.title = ""
          conf.title_pos = "center"
          conf.style = "minimal"
        end,
      },
    },
    lazy = false,
    dependencies = {
      {
        {
          "malewicz1337/oil-git.nvim",
          config = function()
            L("oil-git", function(oilg)
              local signs = L("signs").signs
              oilg.setup {
                symbols = {
                  file = {
                    added = signs.GitSignsLineColAdd.icon,
                    modified = signs.GitSignsLineColChange.icon,
                    renamed = signs.GitSignsRename.icon,
                    deleted = signs.GitSignsLineColDelete.icon,
                    copied = "C",
                    conflict = signs.GitSignsConflict.icon,
                    untracked = signs.GitSignsLineColUntracked.icon,
                    ignored = signs.GitSignsIgnored.icon,
                  },
                  directory = {
                    added = signs.GitSignsLineColAdd.icon,
                    modified = signs.GitSignsLineColChange.icon,
                    renamed = signs.GitSignsRename.icon,
                    deleted = signs.GitSignsLineColDelete.icon,
                    copied = "C",
                    conflict = signs.GitSignsConflict.icon,
                    untracked = signs.GitSignsLineColUntracked.icon,
                    ignored = signs.GitSignsIgnored.icon,
                  },
                },
              }
            end)
          end,
        },
        "nvim-tree/nvim-web-devicons",
      },
    },
  },
}
