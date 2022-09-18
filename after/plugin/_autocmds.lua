local api, bo, wo = vim.api, vim.bo, vim.wo

local blacklist = {
  "DiffviewFiles",
  "NvimTree",
  "DressingInput",
  "help",
  "dapui_breakpoints",
  "dapui_scopes",
  "dapui_stacks",
  "dapui_watches",
  "dapui_console",
  "dap-repl",
  "alpha",
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

api.nvim_create_autocmd({ "VimResized" }, {
  command = "wincmd =",
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
  pattern = { "qf", "help", "lspinfo", "notify", "checkhealth" },
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

local crates_group = api.nvim_create_augroup("Crates", { clear = true })
api.nvim_create_autocmd({ "BufRead" }, {
  group = crates_group,
  pattern = "Cargo.toml",
  callback = function()
    local crates = L "crates"
    if not crates then
      return
    end
    crates.setup { popup = { border = "rounded" } }
    crates.reload()
    local opts = { silent = true, remap = false, buffer = true }
    Map("n", "<leader>cr", crates.reload, opts)
    Map("n", "<leader>cp", crates.show_popup, opts)

    Map("n", "<leader>cv", crates.show_versions_popup, opts)
    Map("n", "<leader>cf", crates.show_features_popup, opts)

    Map("n", "<leader>cu", crates.update_crate, opts)
    Map("v", "<leader>cu", crates.update_crates, opts)
    Map({ "n", "v" }, "<leader>ca", crates.update_all_crates, opts)

    Map("n", "<leader>cU", crates.upgrade_crate, opts)
    Map("v", "<leader>cU", crates.upgrade_crates, opts)
    Map({ "n", "v" }, "<leader>ca", crates.upgrade_all_crates, opts)

    Map("n", "<leader>cR", crates.open_repository, opts)
    Map("n", "<leader>cD", crates.open_documentation, opts)
  end,
})
