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
    icon = "ﴫ",
    texthl = "DiagnosticSignError",
  },
  DapBreakpointCondition = {
    icon = "",
    texthl = "DiagnosticSignWarn",
  },
  DapLogPoint = {
    icon = "",
    texthl = "DiagnosticSignInfo",
  },
  DapCurrentFrame = {
    icon = "",
  },
  GitSignsLineColAdd = {
    hl = "GitSingsAdd",
    icon = "",
    numhl = "GitSignsAddNr",
    linehl = "GitSignsNrAddLn",
  },
  GitSignsLineColTopdelete = {
    hl = "GitSignsDelete",
    icon = "",
    numhl = "GitSignsDeleteNr",
    linehl = "GitSignsDeleteLn",
  },
  GitSignsLineColDelete = {
    hl = "GitSignsDelete",
    icon = "",
    numhl = "GitSignsDeleteNr",
    linehl = "GitSignsDeleteLn",
  },
  GitSignsLineColChange = {
    hl = "GitSignsChange",
    icon = "",
    numhl = "GitSignsChangeNr",
    linehl = "GitSignsChangeLn",
  },
  GitSignsLineColChangedelete = {
    hl = "GitSignsChange",
    icon = "",
    numhl = "GitSignsChangeNr",
    linehl = "GitSignsChangeLn",
  },
  GitSignsLineColUntracked = {
    hl = "GitSingsAdd",
    icon = "",
    numhl = "GitSignsAddNr",
    linehl = "GitSignsNrAddLn",
  },
  GitSignsLineColUnmerged = {
    hl = "GitSingsChange",
    icon = "",
    numhl = "GitSignsChangeNr",
    linehl = "GitSignsChangeLn",
  },
  GitSignsLineColUnstaged = {
    hl = "GitSingsAdd",
    icon = "",
    numhl = "GitSignsAddNr",
    linehl = "GitSignsNrAddLn",
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
    icon = "",
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
    icon = "",
    hl = "NeoTreeModified",
  },
  SnipChoice = {
    icon = "ﯟ",
    hl = "Conditional",
  },
  SnipInsert = {
    icon = "",
    hl = "Visual",
  },
  Selected = {
    icon = "",
  },
  Multi_Select = {
    icon = "",
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
