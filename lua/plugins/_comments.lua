local M = { "numToStr/Comment.nvim" }

M.config = function()
  L("Comment", function(comment)
    comment.setup {
      mappings = {
        basic = true,
        extra = true,
      },
    }
  end)
end

return M
