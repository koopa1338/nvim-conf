local sign_define = vim.fn.sign_define
local M = {}

M.signs = {
  DiagnosticSignError = {
    icon = "",
    texthl = "DiagnosticSignError",
  },
  DiagnosticSignWarn = {
    icon = "",
    texthl = "DiagnosticSignWarn",
  },
  DiagnosticSignInfo = {
    icon = "",
    texthl = "DiagnosticSignInfo",
  },
  DiagnosticSignHint = {
    icon = "",
    texthl = "DiagnosticSignHint",
  },
  DapBreakpoint = {
    icon = "󰠭",
    texthl = "DiagnosticSignError",
  },
  DapBreakpointCondition = {
    icon = "",
    texthl = "DiagnosticSignWarn",
  },
  DapLogPoint = {
    icon = "",
    texthl = "DiagnosticSignInfo",
  },
  DapCurrentFrame = {
    icon = "",
  },
  GitSignsLineColAdd = {
    hl = "GitSingsAdd",
    icon = "",
  },
  GitSignsLineColTopdelete = {
    hl = "GitSignsDelete",
    icon = "",
  },
  GitSignsLineColDelete = {
    hl = "GitSignsDelete",
    icon = "",
  },
  GitSignsLineColChange = {
    hl = "GitSignsChange",
    icon = "",
  },
  GitSignsLineColChangedelete = {
    hl = "GitSignsChange",
    icon = "",
  },
  GitSignsLineColUntracked = {
    hl = "GitSingsAdd",
    icon = "",
  },
  GitSignsLineColUnmerged = {
    hl = "GitSingsChange",
    icon = "",
  },
  GitSignsLineColUnstaged = {
    hl = "GitSingsAdd",
    icon = "󰙴",
  },
  GitSignsIgnored = {
    icon = "",
  },
  GitSignsStaged = {
    icon = "",
  },
  GitSignsConflict = {
    icon = "",
  },
  GitSignsRename = {
    icon = "󰁕",
  },
  Search = {
    icon = "",
    texthl = "Normal",
  },
  FolderClosed = {
    icon = "",
  },
  FolderOpen = {
    icon = "",
  },
  FolderEmpty = {
    icon = "",
  },
  FoldClosed = {
    icon = "",
  },
  FoldOpen = {
    icon = "",
  },
  File = {
    icon = "",
    hl = "NeoTreeFileIcon",
  },
  Modified = {
    icon = "󰏫",
    hl = "NeoTreeModified",
  },
  SnipChoice = {
    icon = "󰛡",
    hl = "Conditional",
  },
  SnipInsert = {
    icon = "",
    hl = "Visual",
  },
  Selected = {
    icon = "󰄾",
  },
  Multi_Select = {
    icon = "󰌖",
  },
}

M.setup = function()
  for name, sign in pairs(M.signs) do
    local opts = {
      text = sign.icon or "",
      hl = sign.hl or nil,
      texthl = sign.texthl or nil,
      numhl = sign.numhl or nil,
      linehl = sign.linehl or nil,
    }
    sign_define(name, opts)
  end
end

Get_sign_def = function(name)
  local result = vim.fn.sign_getdefined(name)
  if #result > 0 then
    return result[1]
  end
  return {}
end

return M
