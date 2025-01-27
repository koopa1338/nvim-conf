local api, bo, wo, o = vim.api, vim.bo, vim.wo, vim.opt

local blacklist = {
  "DiffviewFiles",
  "neo-tree",
  "DressingInput",
  "help",
  "dapui_breakpoints",
  "dapui_scopes",
  "dapui_stacks",
  "dapui_watches",
  "dapui_console",
  "dap-repl",
  "alpha",
  "TelescopePrompt",
}

local numbertoggle = api.nvim_create_augroup("NumberToggle", { clear = true })
api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
  group = numbertoggle,
  callback = function()
    local ft = bo.filetype
    wo.nu = false
    if not Contains(blacklist, ft) then
      wo.rnu = true
      wo.nu = true
    end

    local relative = vim.api.nvim_win_get_config(0).relative
    if relative ~= "" then
      wo.nu = false
      wo.rnu = false
      wo.wrap = true
    end
  end,
})

api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
  group = numbertoggle,
  callback = function()
    local ft = bo.filetype
    wo.nu = false
    if not Contains(blacklist, ft) then
      wo.rnu = false
      wo.nu = true
    end
    if ft == "notify" then
      wo.wrap = false
    end
  end,
})

-- workaround for alacritty bug
api.nvim_create_autocmd({ "VimEnter" }, {
  command = "wincmd +",
})

api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "Substitute", timeout = 200, on_macro = true }
  end,
})

local filetypes = api.nvim_create_augroup("FileTypes", { clear = true })

api.nvim_create_autocmd({ "FileType" }, {
  group = filetypes,
  pattern = blacklist,
  callback = function()
    wo.rnu = false
    wo.nu = false
  end,
})

api.nvim_create_autocmd({ "FileType" }, {
  group = filetypes,
  pattern = { "help" },
  callback = function()
    local opts = { silent = true, remap = false, buffer = 0 }
    Map("n", "<CR>", "<C-]>", opts)
    Map("n", "<BS>", "<C-T>", opts)
    vim.cmd "wincmd L"
    wo.nu = true
  end,
})

api.nvim_create_autocmd({ "FileType" }, {
  group = filetypes,
  pattern = { "qf" },
  callback = function()
    bo.buflisted = false
  end,
})

api.nvim_create_autocmd({ "FileType" }, {
  group = filetypes,
  pattern = { "qf", "help", "lspinfo", "notify", "checkhealth", "msgfloat" },
  callback = function()
    local opts = { silent = true, remap = false, buffer = 0 }
    Map("n", "q", "<cmd>q<CR>", opts)
  end,
})

api.nvim_create_autocmd({ "FileType" }, {
  group = filetypes,
  pattern = { "lua" },
  callback = function()
    vim.opt.shiftwidth = 2
  end,
})

local format_options = api.nvim_create_augroup("FormatOptions", { clear = true })
api.nvim_create_autocmd({ "FileType" }, {
  group = format_options,
  pattern = "*",
  callback = function()
    ---@diagnostic disable-next-line: missing-fields
    vim.opt.formatoptions = {
      a = false, -- Auto formatting is BAD.
      t = false, -- Don't auto format my code. I got linters for that.
      c = true, -- In general, I like it when comments respect textwidth
      q = true, -- Allow formatting comments w/ gq
      o = false, -- O and o, don't continue comments
      r = true, -- But do continue when pressing enter.
      n = true, -- Indent past the formatlistpat, not underneath it.
      j = true, -- Auto-remove comments if possible.
      ["2"] = false, -- I'm not in gradeschool anymore
    }
  end,
})

local staline = api.nvim_create_augroup("Staline", { clear = true })
api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
  group = staline,
  callback = function()
    local ft = bo.filetype
    if Contains({ "alpha", "NvimTree", "mason" }, ft) then
      o.laststatus = 3
    else
      o.laststatus = 2
    end
  end,
})

local resize_events = api.nvim_create_augroup("ResizeEvents", { clear = true })
api.nvim_create_autocmd({ "VimResized" }, {
  group = resize_events,
  callback = function()
    local current_tab = api.nvim_get_current_tabpage()
    vim.cmd [[tabdo wincmd =]]
    api.nvim_set_current_tabpage(current_tab)
  end,
})


-- Don't hide the statusline when switching to cmd mode.
local cmd_line = vim.api.nvim_create_augroup("CmdLine", { clear = true })
api.nvim_create_autocmd('CmdlineEnter', {
    group = cmd_line,
    command = ':set cmdheight=1',
})

api.nvim_create_autocmd('CmdlineLeave', {
    group = cmd_line,
    command = ':set cmdheight=0',
})
