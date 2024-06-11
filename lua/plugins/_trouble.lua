local M = {
  "folke/trouble.nvim",
  dependencies = "kyazdani42/nvim-web-devicons",
  cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
  keys = {
    {
      "<leader>to",
      function()
        local tr = require "trouble"
        if tr.is_open() then
          tr.close()
        else
          vim.api.nvim_command "Trouble"
        end
      end,
      -- "<cmd>Trouble<CR>",
      silent = true,
      desc = "Open trouble selection or close if open",
    },
    {
      "<leader>tr",
      "<cmd>TroubleRefresh<CR>",
      silent = true,
      desc = "Refresh trouble window",
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
    }
  end)
end

return M
