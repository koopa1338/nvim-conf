local signs = require("signs").signs

vim.diagnostic.config {
  signs = {
    text = {
      signs.DiagnosticSignError.icon,
      signs.DiagnosticSignWarn.icon,
      signs.DiagnosticSignInfo.icon,
      signs.DiagnosticSignHint.icon,
    },
    numhl = {
      signs.DiagnosticSignError.texthl,
      signs.DiagnosticSignWarn.texthl,
      signs.DiagnosticSignInfo.texthl,
      signs.DiagnosticSignHint.texthl,
    },
  },
  virtual_text = {
    source = "if_many",
    spacing = 3,
  },
  float = {
    border = vim.g.border_type,
  },
  underline = false,
  severity_sort = true,
}

local ns = vim.api.nvim_create_namespace "severe-diagnostics"
local orig_signs_handler = vim.diagnostic.handlers.signs

local filter_diagnostics = function(diagnostics)
  if not diagnostics then
    return {}
  end

  -- only add one diagnostic per severity level
  local tmp = {}
  for _, cur in pairs(diagnostics) do
    if cur and cur.severity then
      tmp[cur.severity] = cur
    end
  end

  -- return list of diagnostics
  return vim.tbl_values(tmp)
end

vim.diagnostic.handlers.signs = {
  show = function(_, bufnr, diagnostics, opts)
    local fd = filter_diagnostics(diagnostics)
    orig_signs_handler.show(ns, bufnr, fd, opts)
  end,

  hide = function(_, bufnr)
    orig_signs_handler.hide(ns, bufnr)
  end,
}
