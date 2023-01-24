local sign_define = vim.fn.sign_define

-- diagnostic
sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- dap debugger
sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
sign_define("DapLogPoint", { text = "", texthl = "", linehl = "DiagnosticSignInfo", numhl = "" })

-- git
sign_define(
  "GitSignsLineColAdd",
  { hl = "GitSignsAdd", text = "", numhl = "GitSignsAddNr", linehl = "GitSignsNrAddLn" }
)
sign_define(
  "GitSignsLineColTopdelete",
  { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" }
)
sign_define(
  "GitSignsLineColDelete",
  { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" }
)
sign_define(
  "GitSignsLineColChange",
  { hl = "GitSignsChange", text = "", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" }
)
sign_define(
  "GitSignsLineColChangedelete",
  { hl = "GitSignsChange", text = "", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" }
)
sign_define(
  "GitSignsLineColUntracked",
  { hl = "GitSignsAdd", text = "", numhl = "GitSignsAddNr", linehl = "GitSignsNrAddLn" }
)


sign_define("Search", { text = "", texthl = "Normal" })
