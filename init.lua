require "utils"
L "impatient"
L "signs"

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
if L "plugins" then
  return
end

-- set colorscheme
L "walush"

-- load optimized packer compiled lua
L "packer_compiled"

local g, cmd, fn, o, og = vim.g, vim.cmd, vim.fn, vim.opt, vim.opt_global

if vim.version().minor >= 8 then
  -- only use filetype.lua, see https://neovim.io/news/2022/04 section filetype
  g.do_filetype_lua = true
  g.did_load_filetypes = false

  o.winbar = "%=%m %f"
end

-- encoding
og.encoding = "utf-8"
og.fileencoding = "utf-8"

-- general settingsinit
cmd [[
    filetype plugin indent on
    syntax enable
]]

-- globals
g.mapleader = " "
g.mousehide = true
og.termguicolors = true

o.timeout = true
o.ttimeout = false
o.backspace = { "indent", "eol", "start" }
o.showmatch = true
o.whichwrap:append "b,s,h,l,<,>,<,>"
o.scrolljump = 10
o.scrolloff = 5
o.mouse = "a"
o.modeline = true
o.updatetime = 100
o.cmdheight = 2
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
o.completeopt = { "menuone", "noinsert", "noselect" }
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
o.splitright = true
o.splitbelow = true
o.laststatus = 2
o.comments = { sl = "/*", mb = "*", elx = "*/" }
o.linebreak = true
o.breakindent = true
o.breakindentopt = { shift = "2" }

-- Plugin settings

g.titlecase_map_keys = 0

-- disable netrw
-- this is prevents spelllang files from being downloaded, see issue https://github.com/neovim/neovim/issues/7189.
-- We can disable netrw at least in the nvim tree plugin itself.
-- g.loaded_netrw = 1
-- g.loaded_netrwPlugin = 1

-- tex falvor
g.tex_flavor = "latex"

-- luasnip
g.snippets = "luasnip"

-- global border_type
g.border_type = "rounded" -- supported: rounded, single, double

if fn.has "windows" then
  o.fillchars = { vert = "???", eob = "???", diff = "???" }
end

L "settings_custom"
