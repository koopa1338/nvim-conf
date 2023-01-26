local M = { "haringsrob/nvim_context_vt" }

M.config = function()
  L("nvim_context_vt", function(context)
    context.setup {
      prefix = "⟃",
      disable_virtual_lines = true,
    }
  end)
end

return M
