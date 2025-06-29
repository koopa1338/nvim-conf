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
    vim.uv.cwd(),   -- equivalent of `single_file_mode` in lspconfig
  },
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = L("lsp_utils").get_runtime_path(),
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
        library = { vim.api.nvim_get_runtime_file("", true) },
      },
    },
  },
}
