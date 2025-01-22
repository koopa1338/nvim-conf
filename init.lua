---@diagnostic disable: missing-fields
-- globals
local g, cmd, fn, o, og, wo = vim.g, vim.cmd, vim.fn, vim.opt, vim.opt_global, vim.wo
g.mousehide = true
og.termguicolors = true
g.mapleader = " "
-- global border_type
g.border_type = "rounded" -- supported: rounded, single, double

require "utils"
L("signs", function(signs)
  signs.setup()
end)
L "lazy_init"

-- encoding
og.encoding = "utf-8"
og.fileencoding = "utf-8"

-- general settingsinit
cmd [[
    filetype plugin indent on
    syntax enable
]]

o.timeout = true
o.ttimeout = false
o.backspace = { "indent", "eol", "start" }
o.showmatch = true
o.showmode = false
o.whichwrap:append "b,s,h,l,<,>,<,>"
o.scrolljump = 10
o.scrolloff = 5
o.mouse = "a"
o.modeline = true
o.updatetime = 100
o.cmdheight = 0
o.hidden = true
o.confirm = true
o.signcolumn = "auto:3"
o.path:append "**"
o.undodir = fn.expand "~/.config/nvim/undodir"
o.undofile = true
o.inccommand = "split"

-- More natural splitting
o.splitbelow = true
o.splitright = true

o.clipboard = ""
o.swapfile = false
o.spelllang = { "de_de", "en_us" }
o.backup = false
o.writebackup = false

-- line numbers
o.rnu = true
o.nu = true
o.ruler = true

-- search
o.incsearch = true
o.hlsearch = true
o.ignorecase = true
o.smartcase = true

-- wildmenu
o.wildmenu = true
o.wildmode = { longest = "full", "full" }
o.wildoptions = "pum"
o.cpoptions:append "n"
o.infercase = false
o.shortmess:append "c"

-- formatting
o.wrap = true
o.autoindent = true
o.shiftwidth = 4
o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.joinspaces = false
o.laststatus = 2
o.comments = { sl = "/*", mb = "*", elx = "*/" }
o.linebreak = true
o.breakindent = true
o.breakindentopt = { shift = "2" }
o.conceallevel = 2 -- for ligatures, toggle with keymap
wo.foldtext = "v:lua.vim.treesitter.foldtext()"

-- Plugin settings

-- tex falvor
g.tex_flavor = "latex"

-- whichkey
g.whichkey = true

if fn.has "windows" then
  o.fillchars = { vert = "┃", eob = "￭", diff = "╱" }
end

-- command abbreviations
vim.cmd [[cabbrev yfn   :let @+ = expand("%:t")]]
vim.cmd [[cabbrev yfp   :let @+ = expand("%:p")]]
vim.cmd [[cabbrev yrp   :let @+ = expand("%")]]

L "mappings"
L("user_settings", function(settings)
  settings.setup()
end)

L("lazy", function(lazy)
  local opts = L "lazy_opts" or {}
  lazy.setup("plugins", opts)
end)
