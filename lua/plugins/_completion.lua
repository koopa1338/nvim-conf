local M = {
  {
    "saghen/blink.compat",
    version = "2.*",
    lazy = true,
    config = true,
  },
  {
    "saghen/blink.cmp",
    version = "v1.*",
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "crates" },
        providers = {
          crates = {
            name = "crates",
            module = "blink.compat.source",
            score_offset = 3,
          },
        },
      },
      keymap = {
        ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-j>"] = { "select_next", "fallback_to_mappings" },
        ["<C-n>"] = { "show_signature", "hide_signature", "fallback" },
        ["<M-s>"] = {
          function(cmp)
            cmp.show { providers = { "snippets" } }
          end,
        },
        preset = "default",
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      snippets = { preset = "luasnip" },
      signature = { enabled = true, window = { border = vim.g.border_type, show_documentation = true } },
      completion = {
        menu = {
          border = vim.g.border_type,
          max_height = 15,
          scrolloff = 3, -- we have to set this otherwise the scroll of bugs out
          draw = { columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } } },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = {
            border = vim.g.border_type,
          },
        },
      },
      cmdline = {
        enabled = true,
        keymap = { preset = "inherit" },
        sources = function()
          local type = vim.fn.getcmdtype()
          -- Search forward and backward
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          -- Commands
          if type == ":" or type == "@" then
            return { "cmdline", "buffer" }
          end
          return {}
        end,

        completion = {
          trigger = {
            show_on_blocked_trigger_characters = {},
            show_on_x_blocked_trigger_characters = {},
          },
          list = {
            selection = {
              preselect = true,
              auto_insert = true,
            },
          },
          menu = {
            auto_show = true,
          },
          ghost_text = { enabled = true },
        },
      },
    },
  },
}

return M
