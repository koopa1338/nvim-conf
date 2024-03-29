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
    preselect = cmp.PreselectMode.None,
    completion = {
      completeopt = "menu,menuone,noinsert,noselect",
    },
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
      ["<C-CR>"] = cmp.mapping.complete {
        reason = cmp.ContextReason.Auto,
      },
      ["<C-y>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      -- navigate completion menu
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      -- navigate snippet positions
      ["<C-l>"] = cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        end
      end, {
        "i",
        "s",
      }),
      ["<C-h>"] = cmp.mapping(function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
      end, {
        "i",
        "s",
      }),
      -- toggle choices of choice nodes
      ["<C-n>"] = cmp.mapping(function()
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        end
      end, {
        "i",
        "s",
      }),
    },
  }
end

return M
