vim.diagnostic.config {
  virtual_text = {
    source = "if_many",
    spacing = 5,
  },
  underline = false,
  float = { border = vim.g.border_type },
  severity_sort = true,
}
