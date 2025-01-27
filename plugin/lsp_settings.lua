local M = {}

local current_path = function()
  return vim.fn.expand "%:p:h"
end

M.lsp_servers = function(nvim_lsp)
  return {
    clangd = {
      filetypes = { "c", "cc", "cpp", "objc", "objcpp", "h", "hh", "hpp" },
      root_dir = nvim_lsp.util.root_pattern "compile_commands.json" or nvim_lsp.util.find_git_root or current_path,
    },
    gopls = {
      single_file_support = true,
      root_dir = nvim_lsp.util.root_pattern("go.work", "go.mod") or nvim_lsp.util.find_git_root or current_path,
    },
    metals = {},
    ocamlls = {
      root_dir = nvim_lsp.util.root_pattern(".merlin", "package.json") or nvim_lsp.util.find_git_root or current_path,
    },
    rust_analyzer = {
      root_dir = nvim_lsp.util.root_pattern("Cargo.toml", "rust-project.json")
        or nvim_lsp.util.find_git_root
        or current_path,
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
    },
    lua_ls = {
      cmd = { "lua-language-server" },
      single_file_support = true,
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
    },
    pylsp = {
      root_dir = nvim_lsp.util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt")
        or nvim_lsp.util.find_git_root
        or current_path,
    },
    tinymist = {
      root_dir = nvim_lsp.util.find_git_root or current_path,
      offset_encoding = "utf-8",
      settings = {
        formatterMode = "typstfmt",
        exportPdf = "onDocumentHasTitle",
      },
    },
    intelephense = {
      root_dir = nvim_lsp.util.find_git_root or current_path,
    },
    tailwindcss = {
      root_dir = nvim_lsp.util.find_git_root or nvim_lsp.util.root_pattern "tailwind.config.js" or current_path,
    },
  }
end

M.lsp_sources = function(none_ls)
  local sources = {}
  if none_ls then
    sources = {
      black = {
        custom = false,
        type = "formatting",
        external_cmd = "black",
        with = {
          cwd = vim.fn.getcwd,
        },
      },
      stylua = {
        custom = false,
        type = "formatting",
      },
      printenv = {
        custom = false,
        type = "hover",
      },
      shfmt = {
        custom = false,
        type = "formatting",
      },
      prettierd = {
        custom = false,
        type = "formatting",
        with = {
          filetypes = {
            "json",
            "typescriptreact",
            "javascriptreact",
            "css",
            "vue",
            "less",
            "handlebars",
            "jsonc",
            "scss",
            "yaml",
            "html",
            "graphql",
            "javascript",
            "typescript",
          },
        },
      },
    }
  end

  return sources
end

return M
