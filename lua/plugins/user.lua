return {
  {
    "nvim-treesitter/playground",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
  },
  {
    "glacambre/firenvim",
    build = function()
      vim.fn["firenvim#install"](0)
    end,
    lazy = false,
  },
  -- chatGPT {
  --   "jackMort/ChatGPT.nvim",
  --   config = function()
  --     require("chatgpt").setup({
  --       -- optional configuration
  --     })
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim"
  --   }
  -- }
}
