Map("n", "<Esc>", "<cmd>nohl<CR>", { silent = true })
Map("n", "<C-c>", "<Esc>", { silent = true })

-- buffers
Map("n", "<leader>bp", "<cmd>b#<CR>", { silent = true, desc = "Open Previous Buffer" })
Map("n", "<leader>bd", "<cmd>bdelete<CR>", { silent = true, desc = "Delete current Buffer" })
Map("n", "<leader>bD", "<cmd>%bdelete<CR>", { silent = true, desc = "Delete all other Buffers" })
Map("n", "<leader>BD", "<cmd>.+,$bdelete<CR>", { silent = true, desc = "Delete all other Buffers" })
Map("n", "<leader>bw", "<cmd>bwipeout<CR>", { silent = true, desc = "Wipeout current Buffer" })
Map("n", "<leader>bW", "<cmd>%bwipeout<CR>", { silent = true, desc = "Wipeout all other Buffers" })
Map("n", "<leader>BW", "<cmd>.+,$bwipeout<CR>", { silent = true, desc = "Wipe all other Buffers" })
Map("n", "<leader>bmm", "<cmd>bmodified<CR>", { silent = true, desc = "" })
Map("n", "<leader>bmx", "<cmd>sbmodified<CR>", { silent = true, desc = "" })
Map("n", "<leader>bmv", "<cmd>vertical sbmodified<CR>", { silent = true, desc = "" })

-- windows
Map("n", "<leader>wo", "<cmd>only<CR>", { silent = true, desc = "Close all other Windows" })
Map("n", "<leader>wsx", "<cmd>split<CR>", { silent = true, desc = "Horizontal Split" })
Map("n", "<leader>wsv", "<cmd>vsplit<CR>", { silent = true, desc = "Vertical Split" })
Map("n", "<leader>wnx", "<cmd>new<CR>", { silent = true, desc = "New Horizontal Window" })
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

Map("n", "<C-s>", "<cmd>w<CR>", {})
Map("i", "<C-s>", "<Esc><cmd>w<CR>", {})
Map("t", "<Esc><Esc>", "<C-\\><C-n>", {})

-- movement
Map({ "n", "v" }, "j", "gj", {})
Map({ "n", "v" }, "k", "gk", {})
Map({ "n", "v" }, "H", "^", {})
Map({ "n", "v" }, "L", "$", {})

Map("n", "<M-o>", ":cn<CR>", { desc = "Next Quickfix Item" })
Map("n", "<M-i>", ":cp<CR>", { desc = "Previous Quickfix Item" })
Map("n", "<C-M-o>", ":lne<CR>", { desc = "Next Location Item" })
Map("n", "<C-M-i>", ":lp<CR>", { desc = "Previous Location Item" })

-- Reselect visual block after indent
Map("v", "<", "<gv", { desc = "Increase Indent Visual Block" })
Map("v", ">", ">gv", { desc = "Decrease Indent Visual Block" })

-- search for multiple words seperated by |
-- Example /\vtest|live highlights test and live
Map("n", "g/", "/\\v", {})

-- yank and paste mappings
Map("v", "p", '"_dP', {})
Map("n", "gp", '"+p', {})
Map("v", "gp", '"_d"+P', {})

Map("n", "gP", '"+P', {})
Map({ "n", "v" }, "gy", '"+y', {})
Map("n", "gY", '"+y$', {})
Map("n", "Y", "y$", {})

Map("n", "<leader><leader>m", "<cmd>Messages<CR>", { silent = true, desc = "Messenger" })

-- editing
-- <C-H> is <C-BS>, see: https://vi.stackexchange.com/questions/16139/s-bs-and-c-bs-mappings-not-working
Map("i", "<C-H>", "<C-W>", {})

Map({ "n", "v", "i" }, "<F1>", "<nop>", { silent = true })

L("which-key", function(wk)
  wk.register({
    b = {
      name = "+buffers",
      p = { "Open Previous Buffer" },
      d = { "Delete current Buffer" },
      D = { "Delete all other Buffers" },
      w = { "Wipeout current Buffer" },
      W = { "Wipeout all other Buffers" },
      m = {
        name = "+modified",
        m = {},
        x = {},
        v = {},
      },
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
        x = { "Horizontal Split" },
        v = { "Vertical Split" },
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
