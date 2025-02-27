-- local M = {
--   "hrsh7th/nvim-cmp",
--   dependencies = {
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-path",
--     "hrsh7th/cmp-nvim-lsp",
--     "saadparwaiz1/cmp_luasnip",
--     "onsails/lspkind-nvim",
--     {
--       "MattiasMTS/cmp-dbee",
--       dependencies = {
--         { "kndndrj/nvim-dbee" },
--       },
--       ft = "sql", -- optional but good to have
--     },
--   },
--   event = "InsertEnter",
-- }
--
-- M.config = function()
--   local cmp = L "cmp"
--   local ls = L "luasnip"
--   local lspkind = L "lspkind"
--
--   vim.snippet.expand = ls.lsp_expand
--
--   ---@diagnostic disable-next-line: duplicate-set-field
--   vim.snippet.active = function(filter)
--     filter = filter or {}
--     filter.direction = filter.direction or 1
--
--     if filter.direction == 1 then
--       return ls.expand_or_jumpable()
--     else
--       return ls.jumpable(filter.direction)
--     end
--   end
--
--   ---@diagnostic disable-next-line: duplicate-set-field
--   vim.snippet.jump = function(direction)
--     if direction == 1 then
--       if ls.expandable() then
--         return ls.expand_or_jump()
--       else
--         return ls.jumpable(1) and ls.jump(1)
--       end
--     else
--       return ls.jumpable(-1) and ls.jump(-1)
--     end
--   end
--
--   vim.snippet.stop = ls.unlink_current
--
--   Map({ "i", "s" }, "<c-l>", function()
--     return vim.snippet.active { direction = 1 } and vim.snippet.jump(1)
--   end, { silent = true })
--
--   Map({ "i", "s" }, "<c-h>", function()
--     return vim.snippet.active { direction = -1 } and vim.snippet.jump(-1)
--   end, { silent = true })
--
--   local cmp_kinds = {
--     Class = "",
--     Color = "",
--     Constant = "",
--     Constructor = "",
--     Enum = "",
--     EnumMember = "",
--     Event = "",
--     Field = "󰜢",
--     File = "",
--     Folder = "",
--     Function = "󰊕",
--     Interface = "󰆧",
--     Keyword = "󰌋",
--     Method = "",
--     Module = "",
--     Operator = "󰘧",
--     Property = "",
--     Reference = "󰌹",
--     Snippet = "󰘍",
--     Struct = "",
--     Text = "",
--     TypeParameter = "󰊄",
--     Unit = "",
--     Value = "󰎠",
--     Variable = "",
--   }
--
--   ---@diagnostic disable: need-check-nil
--   cmp.setup {
--     preselect = cmp.PreselectMode.None,
--     completion = {
--       completeopt = "menu,menuone,noinsert,noselect",
--     },
--     snippet = {
--       expand = function(args)
--         vim.snippet.expand(args.body)
--       end,
--     },
--     sources = {
--       { name = "nvim_lsp" },
--       { name = "luasnip" },
--       { name = "buffer" },
--       { name = "path" },
--       { name = "crates" },
--       { name = "cmp-dbee" },
--     },
--     formatting = {
--       fields = { "kind", "abbr", "menu" },
--       format = function(entry, vim_item)
--         local kind = lspkind.cmp_format { symbol_map = cmp_kinds }(entry, vim_item)
--         local strings = vim.split(kind.kind, "%s", { trimempty = false })
--         kind.kind = " " .. strings[1] .. " "
--         kind.menu = "    (" .. strings[2] .. ")"
--
--         return kind
--       end,
--     },
--     window = {
--       completion = {
--         border = vim.g.border_type,
--         col_offset = -3,
--         side_padding = 0,
--       },
--       documentation = {
--         border = vim.g.border_type,
--         max_width = 200,
--       },
--     },
--     mapping = {
--       ["<C-c>"] = cmp.mapping.close(),
--       ["<M-k>"] = cmp.mapping.scroll_docs(-4),
--       ["<M-j>"] = cmp.mapping.scroll_docs(4),
--       ["<M-s>"] = cmp.mapping.complete {
--         config = {
--           sources = {
--             { name = "luasnip" },
--           },
--         },
--       },
--       ["<C-CR>"] = cmp.mapping.complete {
--         reason = cmp.ContextReason.Auto,
--       },
--       ["<C-y>"] = cmp.mapping(
--         cmp.mapping.confirm {
--           behavior = cmp.ConfirmBehavior.Insert,
--           select = true,
--         },
--         { "i", "c" }
--       ),
--       -- navigate completion menu
--       ["<C-j>"] = cmp.mapping.select_next_item(),
--       ["<C-k>"] = cmp.mapping.select_prev_item(),
--       ["<C-n>"] = cmp.mapping(function()
--         if ls.choice_active() then
--           ls.change_choice(1)
--         end
--       end, {
--         "i",
--         "s",
--       }),
--     },
--   }
-- end
--
-- return M

local M = {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = "rafamadriz/friendly-snippets",

  -- use a release tag to download pre-built binaries
  version = "*",
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-e: Hide menu
    -- C-k: Toggle signature help
    --
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
      -- set to 'none' to disable the 'default' preset
      preset = 'default',

      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },

      -- disable a keymap from the preset
      ['<C-e>'] = {},

      -- show with a list of providers
      ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },
    completion = {
      menu = { border = vim.g.border_type },
      documentation = { window = { border = vim.g.border_type } },
    },
    signature = { window = { border = vim.g.border_type } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}

return M
