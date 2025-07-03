local get_runtime_path = function()
  local runtime_path = vim.split(package.path, ";")
  return vim.tbl_extend("keep", runtime_path,
    { "?/?.lua",
      "lua/?.lua",
      "lua/?/init.lua",
      "plugin/?.lua",
      "plugin/?/init.lua",
    })
end

return {
  cmd = { "lua-language-server" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
    vim.uv.cwd(), -- equivalent of `single_file_mode` in lspconfig
  },
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = get_runtime_path(),
      },
      completion = {
        keywordSnippet = "Disable",
        showWord = "Disable",
      },
      diagnostics = {
        enable = true,
        globals = { "vim" },
      },
      workspace = {
        library = { vim.env.VIMRUNTIME, },
      },
    }
  },
}
