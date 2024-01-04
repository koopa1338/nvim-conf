local M = { "kevinhwang91/nvim-bqf", ft = { "qf" } }

M.config = function()
  L("bqf", function(bqf)
    bqf.setup {
      func_map = {
        open = "o",
        copen = "<CR>",
        ptogglemode = "p",
        ptoggleitem = "zp",
      },
    }
  end)
end

return M
