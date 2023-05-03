local M = {
  "haringsrob/nvim_context_vt",
  event = "BufReadPre",
  config = true,
}

M.opts = {
  prefix = "⟃",
  disable_virtual_lines = true,
}

return M
