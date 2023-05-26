local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind-nvim",
  },
  event = "InsertEnter",
}

M.config = function()
  local cmp = L "cmp"
  local luasnip = L "luasnip"
  local lspkind = L "lspkind"

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
  end

  local cmp_kinds = {
    Class = "",
    Color = "",
    Constant = "",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "󰜢",
    File = "",
    Folder = "",
    Function = "󰊕",
    Interface = "󰆧",
    Keyword = "󰌋",
    Method = "",
    Module = "",
    Operator = "󰘧",
    Property = "",
    Reference = "󰌹",
    Snippet = "󰘍",
    Struct = "",
    Text = "",
    TypeParameter = "󰊄",
    Unit = "",
    Value = "󰎠",
    Variable = "",
  }

  ---@diagnostic disable: need-check-nil
  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
      { name = "crates" },
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind = lspkind.cmp_format { symbol_map = cmp_kinds }(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = false })
        kind.kind = " " .. strings[1] .. " "
        kind.menu = "    (" .. strings[2] .. ")"

        return kind
      end,
    },
    window = {
      completion = {
        border = vim.g.border_type,
        col_offset = -3,
        side_padding = 0,
      },
      documentation = {
        border = vim.g.border_type,
        max_width = 200,
      },
    },
    experimental = {
      native_menu = false,
      -- ghost_text = {
      --   hl_group = "Comment",
      -- },
    },
    mapping = {
      ["<C-c>"] = cmp.mapping.close(),
      ["<M-k>"] = cmp.mapping.scroll_docs(-4),
      ["<M-j>"] = cmp.mapping.scroll_docs(4),
      ["<M-s>"] = cmp.mapping.complete {
        config = {
          sources = {
            { name = "luasnip" },
          },
        },
      },
      ["<C-k>"] = cmp.mapping.complete {
        reason = cmp.ContextReason.Auto,
      },
      ["<cr>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = false,
      },
      -- navigate completion menu
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      -- navigate snippet positions
      ["<C-f>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<C-b>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      -- toggle choices of choice nodes
      ["<C-y>"] = cmp.mapping(function(fallback)
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },
  }
end

return M
