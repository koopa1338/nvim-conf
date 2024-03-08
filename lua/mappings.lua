Map("n", "<Esc>", "<cmd>nohl<CR>", { silent = true, desc = "Remove search hl" })
Map("n", "<C-c>", "<Esc>", { silent = true })

-- buffers
Map("n", "<leader>bp", "<cmd>b#<CR>", { silent = true, desc = "Open Previous Buffer" })
Map("n", "<leader>bd", "<cmd>bdelete<CR>", { silent = true, desc = "Delete current Buffer" })
Map("n", "<leader>bD", "<cmd>%bdelete<CR>", { silent = true, desc = "Delete all other Buffers" })
Map("n", "<leader>BD", "<cmd>.+,$bdelete<CR>", { silent = true, desc = "Delete all other Buffers" })
Map("n", "<leader>bw", "<cmd>bwipeout<CR>", { silent = true, desc = "Wipeout current Buffer" })
Map("n", "<leader>bW", "<cmd>%bwipeout<CR>", { silent = true, desc = "Wipeout all other Buffers" })
Map("n", "<leader>BW", "<cmd>.+,$bwipeout<CR>", { silent = true, desc = "Wipe all other Buffers" })
Map("n", "<leader>bmm", "<cmd>bmodified<CR>", { silent = true, desc = "Open next modified buffer" })
Map(
  "n",
  "<leader>bmx",
  "<cmd>sbmodified<CR>",
  { silent = true, desc = "Open next modified buffer in a horizontal split" }
)
Map(
  "n",
  "<leader>bmv",
  "<cmd>vertical sbmodified<CR>",
  { silent = true, desc = "Open next modified buffer in a vertical split" }
)

-- windows
Map("n", "<leader>wo", "<cmd>only<CR>", { silent = true, desc = "Close all other Windows" })
Map("n", "<leader>wsh", "<cmd>split<CR>", { silent = true, desc = "Horizontal Split" })
Map("n", "<leader>wsv", "<cmd>vsplit<CR>", { silent = true, desc = "Vertical Split" })
Map("n", "<leader>wnh", "<cmd>new<CR>", { silent = true, desc = "New Horizontal Window" })
Map("n", "<leader>wnv", "<cmd>vnew<CR>", { silent = true, desc = "New Vertical Window" })
Map("n", "<leader>wq", "<cmd>close<CR>", { silent = true, desc = "Close current Window" })
Map("n", "<leader>wt", "<cmd>tabclose<CR>", { silent = true, desc = "Close current Tab" })
Map("n", "<C-j>", ":wincmd j<CR>", { silent = true, desc = "Goto Window Down" })
Map("n", "<C-k>", ":wincmd k<CR>", { silent = true, desc = "Goto Window Up" })
Map("n", "<C-h>", ":wincmd h<CR>", { silent = true, desc = "Goto Window Left" })
Map("n", "<C-l>", ":wincmd l<CR>", { silent = true, desc = "Goto Window Right" })
Map("n", "<leader><C-j>", "<cmd>wincmd J<CR>", { silent = true, desc = "Move Window Down" })
Map("n", "<leader><C-k>", "<cmd>wincmd K<CR>", { silent = true, desc = "Move Window Up" })
Map("n", "<leader><C-h>", "<cmd>wincmd H<CR>", { silent = true, desc = "Move Window Left" })
Map("n", "<leader><C-l>", "<cmd>wincmd L<CR>", { silent = true, desc = "Move Window Right" })

Map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save the current buffer" })
Map("i", "<C-s>", "<Esc><cmd>w<CR>", { desc = "Save the current buffer" })
Map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Get into normal mode in a terminal buffer" })

-- movement
Map({ "n", "x" }, "j", "gj", {})
Map({ "n", "x" }, "k", "gk", {})
Map({ "n", "x" }, "H", "^", { desc = "Go to the first none space character of the line" })
Map({ "n", "x" }, "L", "$", { desc = "Go to the last none space character of the line" })

-- Reselect visual block after indent
Map("v", "<", "<gv", { desc = "Increase Indent Visual Block" })
Map("v", ">", ">gv", { desc = "Decrease Indent Visual Block" })

-- search for multiple words seperated by |
-- Example /\vtest|live highlights test and live
Map("n", "g/", "/\\v", { desc = "Search with very magic option" })

-- yank and paste mappings
Map("v", "p", '"_dP', {})
Map("n", "gp", '"+p', {})
Map("v", "gp", '"_d"+P', {})

Map("n", "gP", '"+P', { desc = "Paste before current position from system clipboard" })
Map({ "n", "v" }, "gy", '"+y', { desc = "Copy into system clipboard" })
Map("n", "gY", '"+y$', { desc = "Copy from current position to the end of the line into system clipboard" })
Map("n", "Y", "y$", { desc = "Copy from current position to the end of the line" })

Map("n", "<leader><leader>m", "<cmd>Messages<CR>", { silent = true, desc = "Open Messages" })

-- editing
-- <C-H> is <C-BS>, see: https://vi.stackexchange.com/questions/16139/s-bs-and-c-bs-mappings-not-working
Map("i", "<C-H>", "<C-W>", {})
Map("n", "go", "o<Esc>", { desc = "add new line without leaving normal mode" })
Map("n", "gO", "O<Esc>", { desc = "add new line above without leaving normal mode" })

Map({ "n", "v", "i" }, "<F1>", "<nop>", { silent = true })

Map({ "n" }, "<leader><leader>q", "<cmd>copen<CR>", { silent = true, desc = "Open qf list" })
Map({ "n" }, "<leader><leader>l", "<cmd>lopen<CR>", { silent = true, desc = "Open loc list" })

-- settings
Map("n", "<leader><leader>sl", function()
  if vim.o.conceallevel > 0 then
    vim.o.conceallevel = 0
  else
    vim.o.conceallevel = 2
  end
end, { silent = true, desc = "Toggle conceallevel for ligatures" })
