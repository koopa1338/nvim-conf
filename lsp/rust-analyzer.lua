return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = {
    "Cargo.toml",
    "rust-project.json",
    ".git",
    vim.uv.cwd(),
  },
  -- this is vor passing environments to devcontainers
  container = {
    env = {
      CARGO_HOME = vim.env.HOME .. "/.cargo",
    },
    cmd = { vim.env.HOME .. "/.cargo/bin/rust-analyzer" },
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
