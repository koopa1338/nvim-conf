return {
  cmd = { "gopls" },
  filetypes = { "go" },
  root_markers = {
    "go.work",
    "go.mod",
    ".git",
    vim.uv.cwd(),
  },
}
