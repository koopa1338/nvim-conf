local M = {
  "haringsrob/nvim_context_vt",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  config = true,
}

M.opts = {
  prefix = "⟃",
  disable_virtual_lines = true,
}

return M
