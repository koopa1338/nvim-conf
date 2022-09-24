Map("n", "<Esc>", ":nohl<CR>", { silent = true, remap = false })
Map("n", "<C-c>", "<Esc>", { silent = true, remap = false })

-- buffers
Map("n", "<leader>bp", ":b#<CR>", { silent = true, remap = false })
Map("n", "<leader>bd", ":bdelete<CR>", { silent = true, remap = false })
Map("n", "<leader>bD", ":%bdelete<CR>", { silent = true, remap = false })
Map("n", "<leader>BD", ":.+,$bdelete<CR>", { silent = true, remap = false })
Map("n", "<leader>bw", ":bwipeout<CR>", { silent = true, remap = false })
Map("n", "<leader>bW", ":%bwipeout<CR>", { silent = true, remap = false })
Map("n", "<leader>BW", ":.+,$bwipeout<CR>", { silent = true, remap = false })

-- windows
Map("n", "<leader>wo", ":only<CR>", { silent = true, remap = false })
Map("n", "<leader>wsx", ":split<CR>", { silent = true, remap = false })
Map("n", "<leader>wsv", ":vsplit<CR>", { silent = true, remap = false })
Map("n", "<leader>wnx", ":new<CR>", { silent = true, remap = false })
Map("n", "<leader>wnv", ":vnew<CR>", { silent = true, remap = false })
Map("n", "<leader>wq", ":close<CR>", { silent = true, remap = false })
Map("n", "<leader>wt", ":tabclose<CR>", { silent = true, remap = false })
Map("n", "<C-j>", ":wincmd j<CR>", { silent = true })
Map("n", "<C-k>", ":wincmd k<CR>", { silent = true })
Map("n", "<C-h>", ":wincmd h<CR>", { silent = true })
Map("n", "<C-l>", ":wincmd l<CR>", { silent = true })
Map("n", "<M-j>", ":wincmd +<CR>", { silent = true })
Map("n", "<M-k>", ":wincmd -<CR>", { silent = true })
Map("n", "<M-h>", ":wincmd <<CR>", { silent = true })
Map("n", "<M-l>", ":wincmd ><CR>", { silent = true })
Map("n", "<leader><C-j>", ":wincmd J<CR>", { silent = true })
Map("n", "<leader><C-k>", ":wincmd K<CR>", { silent = true })
Map("n", "<leader><C-h>", ":wincmd H<CR>", { silent = true })
Map("n", "<leader><C-l>", ":wincmd L<CR>", { silent = true })

Map("n", "<C-s>", ":w<CR>", { remap = false })
Map("i", "<C-s>", "<Esc>:w<CR>", { remap = false })
Map("t", "<Esc><Esc>", "<C-\\><C-n>", {})

-- movement
Map({ "n", "v" }, "j", "gj", {})
Map({ "n", "v" }, "k", "gk", {})
Map({ "n", "v" }, "H", "^", {})
Map({ "n", "v" }, "L", "$", {})

Map("n", "<M-o>", ":cn<CR>", {})
Map("n", "<M-i>", ":cp<CR>", {})

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

Map("n", "<leader><leader>m", ":Messages<CR>", { silent = true })

L("which-key", function(wk)
  wk.register({
    b = {
      name = "+buffers",
      o = { "Open Previous Buffer" },
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
