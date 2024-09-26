local M = {
  "jake-stewart/multicursor.nvim",
  event = "VimEnter",
  branch = "1.0",
}

M.config = function()
  L("multicursor-nvim", function(mc)
    mc.setup()
  end)
end

return M
