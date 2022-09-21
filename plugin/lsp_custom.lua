local servers = {}

L("lspconfig", function(nvim_lsp)
  -- Make runtime files discoverable to the server
  local get_runtime_path = function()
    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    return runtime_path
  end

  servers = {
    clangd = {
      filetypes = { "c", "cc", "cpp", "objc", "objcpp" },
    },
    gopls = {
      cmd = { "gopls", "serve" },
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    },
    html = {
      cmd = { "vscode-html-language-server", "--stdio" },
      root_dir = nvim_lsp.util.root_pattern "index.html" or nvim_lsp.util.find_git_root,
    },
    jdtls = {
      filetypes = { "java" },
      cmd = { "jdtls" },
      root_dir = nvim_lsp.util.root_pattern("mvnw", "gradlew", "pom.xml", "build.gradle")
        or nvim_lsp.util.find_git_root,
    },
    metals = {},
    ocamlls = {
      root_dir = nvim_lsp.util.root_pattern(".merlin", "package.json") or nvim_lsp.util.find_git_root,
    },
    rust_analyzer = {
      root_dir = nvim_lsp.util.root_pattern("Cargo.toml", "rust-project.json") or nvim_lsp.util.find_git_root,
    },
    sumneko_lua = {
      cmd = { "lua-language-server" },
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
            library = { vim.api.nvim_get_runtime_file("", true) },
          },
        },
      },
    },
    tsserver = {
      cmd = { "typescript-language-server", "--stdio" },
      root_dir = nvim_lsp.util.find_git_root or nvim_lsp.util.find_node_modules_root,
    },
  }
end)

return servers
