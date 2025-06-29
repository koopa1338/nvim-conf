return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = {
    "Cargo.toml",
    "rust-project.json",
    ".git",
    vim.uv.cwd(),
  },
  settings = {
    ["rust-analyzer"] = {
      procMacro = {
        ignored = {
          leptos_macro = {
            "server",
            "component",
          },
        },
        attributes = {
          enable = true,
        },
        enable = true,
      },
      cargo = {
        features = "all",
      },
    },
  },

}
