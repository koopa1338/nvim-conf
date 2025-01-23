local toggle_mode = function(mode)
  L("trouble", function(tr)
    if tr.is_open(mode) then
      tr.close(mode)
    else
      tr.open(mode)
    end
  end)
end

local M = {
  "folke/trouble.nvim",
  dependencies = "kyazdani42/nvim-web-devicons",
  cmd = { "Trouble" },
  keys = {
    {
      "<leader>tto",
      "<cmd>Trouble<cr>",
      silent = true,
      desc = "Open trouble selection or close if open",
    },
    {
      "<leader>ttr",
      function()
        toggle_mode("lsp_references")
      end,
      silent = true,
      desc = "Open lsp references with trouble",
    },
    {
      "<leader>tts",
      function()
        toggle_mode("lsp_document_symbols")
      end,
      silent = true,
      desc = "Open lsp document symbols with trouble",
    },
    {
      "<leader>ttS",
      function()
        toggle_mode("symbols")
      end,
      silent = true,
      desc = "Open trouble symbols",
    },
  },
}

M.config = function()
  L("trouble", function(trouble)
    trouble.setup {
      auto_preview = false,
      auto_fold = false,
      auto_close = true,
      use_diagnostic_signs = true,
      height = 15,
      icons = {
        fold_open = Get_sign_def("FoldOpen").icon,
        fold_closed = Get_sign_def("FoldClosed").icon,
      },
      keys = {
        o = "jump",
        ["<cr>"] = "jump_close",
        ["<tab>"] = "jump_close",
      },
      modes = {
        lsp_document_symbols = {
          win = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.4,
          },
        },
        symbols = {
          win = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.3,
          },
        },
      },
    }
  end)
end

return M
