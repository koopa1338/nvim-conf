local g = vim.g

g.diagnostic_enable_virtual_text = 1
g.diagnostic_enable_underline = 0
g.diagnostic_trimmed_virtual_text = "40"
g.diagnostic_insert_delay = 1

Map("n", "<leader>D", ":Trouble<CR>", { silent = true })

vim.diagnostic.config {
  float = { border = "rounded" },
}
