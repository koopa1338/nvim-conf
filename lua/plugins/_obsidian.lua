local M = {
  "epwalsh/obsidian.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  ft = "markdown",
  cmd = {
    "ObsidianOpen",
    "ObsidianNew",
    "ObsidianSearch",
    "ObsidianQuickSwitch",
  },
}

M.config = function()
  L("obsidian", function(obsidian)
    obsidian.setup {
      workspaces = {
        {
          name = "Notes",
          path = "~/Notes/",
        },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      mappings = {
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
      },
      templates = {
        folder = "Templates",
      },
      note_id_func = function(title)
        local result = tostring(os.date("%Y-%m-%d_%H-%M", os.time()))
        if title ~= nil then
          result = result .. "-" .. title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        end
        return result
      end,
    }
  end)
end

return M
