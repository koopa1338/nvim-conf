Map("n", "<Esc>", "<cmd>nohl<CR>", { silent = true, remap = false })
Map("n", "<C-c>", "<Esc>", { silent = true, remap = false })

-- buffers
Map("n", "<leader>bp", "<cmd>b#<CR>", { silent = true, remap = false })
Map("n", "<leader>bd", "<cmd>bdelete<CR>", { silent = true, remap = false })
Map("n", "<leader>bD", "<cmd>%bdelete<CR>", { silent = true, remap = false })
Map("n", "<leader>BD", "<cmd>.+,$bdelete<CR>", { silent = true, remap = false })
Map("n", "<leader>bw", "<cmd>bwipeout<CR>", { silent = true, remap = false })
Map("n", "<leader>bW", "<cmd>%bwipeout<CR>", { silent = true, remap = false })
Map("n", "<leader>BW", "<cmd>.+,$bwipeout<CR>", { silent = true, remap = false })

-- windows
Map("n", "<leader>wo", "<cmd>only<CR>", { silent = true, remap = false })
Map("n", "<leader>wsx", "<cmd>split<CR>", { silent = true, remap = false })
Map("n", "<leader>wsv", "<cmd>vsplit<CR>", { silent = true, remap = false })
Map("n", "<leader>wnx", "<cmd>new<CR>", { silent = true, remap = false })
Map("n", "<leader>wnv", "<cmd>vnew<CR>", { silent = true, remap = false })
Map("n", "<leader>wq", "<cmd>close<CR>", { silent = true, remap = false })
Map("n", "<leader>wt", "<cmd>tabclose<CR>", { silent = true, remap = false })
Map("n", "<C-j>", ":wincmd j<CR>", { silent = true })
Map("n", "<C-k>", ":wincmd k<CR>", { silent = true })
Map("n", "<C-h>", ":wincmd h<CR>", { silent = true })
Map("n", "<C-l>", ":wincmd l<CR>", { silent = true })
Map("n", "<M-j>", ":wincmd +<CR>", { silent = true })
Map("n", "<M-k>", ":wincmd -<CR>", { silent = true })
Map("n", "<M-h>", ":wincmd <<CR>", { silent = true })
Map("n", "<M-l>", ":wincmd ><CR>", { silent = true })
Map("n", "<leader><C-j>", "<cmd>wincmd J<CR>", { silent = true })
Map("n", "<leader><C-k>", "<cmd>wincmd K<CR>", { silent = true })
Map("n", "<leader><C-h>", "<cmd>wincmd H<CR>", { silent = true })
Map("n", "<leader><C-l>", "<cmd>wincmd L<CR>", { silent = true })

Map("n", "<C-s>", "<cmd>w<CR>", { remap = false })
Map("i", "<C-s>", "<Esc><cmd>w<CR>", { remap = false })
Map("t", "<Esc><Esc>", "<C-\\><C-n>", {})

-- movement
Map({ "n", "v" }, "j", "gj", {})
Map({ "n", "v" }, "k", "gk", {})
Map({ "n", "v" }, "H", "^", {})
Map({ "n", "v" }, "L", "$", {})

Map("n", "<M-o>", ":cn<CR>", {})
Map("n", "<M-i>", ":cp<CR>", {})
Map("n", "<C-M-o>", ":lne<CR>", {})
Map("n", "<C-M-i>", ":lp<CR>", {})

-- Reselect visual block after indent
Map("v", "<", "<gv", {})
Map("v", ">", ">gv", {})

-- search for multiple words seperated by |
-- Example /\vtest|live highlights test and live
Map("n", "g/", "/\\v", {})

-- yank and paste mappings
Map("v", "p", '"_dP', { remap = false })
Map("n", "gp", '"+p', { remap = false })
Map("v", "gp", '"_d"+P', { remap = false })

Map("n", "gP", '"+P', { remap = false })
Map({ "n", "v" }, "gy", '"+y', { remap = true })
Map("n", "gY", '"+y$', { remap = false })
Map("n", "Y", "y$", { remap = false })

Map("n", "<leader><leader>m", "<cmd>Messages<CR>", { silent = true })

-- editing
-- <C-H> is <C-BS>, see: https://vi.stackexchange.com/questions/16139/s-bs-and-c-bs-mappings-not-working
Map("i", "<C-H>", "<C-W>", {})

L("which-key", function(wk)
  wk.register({
    b = {
      name = "+buffers",
      p = { "Open Previous Buffer" },
      d = { "Delete current Buffer" },
      D = { "Delete all other Buffers" },
      w = { "Wipeout current Buffer" },
      W = { "Wipeout all other Buffers" },
    },
    g = {
      m = { "Messenger" },
    },
    w = {
      name = "+windows",
      q = { "Close current Window" },
      t = { "Close current Tab" },
      o = { "Close all other Windows" },
      n = {
        name = "+new",
        x = { "New Horizontal Window" },
        v = { "New Vertical Window" },
      },
      s = {
        name = "+split",
        x = { "New Horizontal Window" },
        v = { "New Vertical Window" },
      },
    },
    B = {
      name = "+buffers",
      D = { "Delete all other Buffers" },
      W = { "Wipe all other Buffers" },
    },
    ["<C-S>"] = { "Save File" },
    ["<C-H>"] = { "Move Window Left" },
    ["<C-J>"] = { "Move Window Down" },
    ["<C-K>"] = { "Move Window Up" },
    ["<C-L>"] = { "Move Window Right" },
  }, { prefix = "<leader>" })
end)
