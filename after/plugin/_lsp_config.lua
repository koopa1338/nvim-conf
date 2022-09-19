L("lspconfig", function(nvim_lsp)
  local log_lvl = vim.log.levels
  local unsupported_title = "LSP Provider not supported"
  local bt = vim.g.border_type

  local notify_unsupported_lsp = function(message, title)
    vim.notify(message, log_lvl.INFO, { title = title or unsupported_title })
  end

  -- lsp config
  local opts = { silent = true }
  local custom_attach = function(client)
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
    local capabilities = client.server_capabilities

    if capabilities.declarationProvider then
      Map("n", "<leader>lD", vim.lsp.buf.declaration, opts)
    else
      Map("n", "<leader>lD", function()
        notify_unsupported_lsp "LSP does not support jump to declaration"
      end, opts)
    end

    if capabilities.definitionProvider then
      Map("n", "<leader>ld", vim.lsp.buf.definition, opts)
    else
      Map("n", "<leader>ld", function()
        notify_unsupported_lsp "LSP does not support jump to defenition"
      end, opts)
    end

    if capabilities.typeDefinitionProvider then
      Map("n", "<leader>lT", vim.lsp.buf.type_definition, opts)
    else
      Map("n", "<leader>lT", function()
        notify_unsupported_lsp "LSP does not support show document type defenition"
      end, opts)
    end

    if capabilities.renameProvider then
      Map("n", "<leader>lr", vim.lsp.buf.rename, opts)
    else
      Map("n", "<leader>lr", function()
        notify_unsupported_lsp "LSP does not support show rename"
      end, opts)
    end

    if capabilities.documentFormattingProvider then
      Map("n", "<leader>lf", function()
        if vim.version().minor >= 8 then
          vim.lsp.buf.format { async = true }
        else
          vim.lsp.buf.formatting()
        end
      end, opts)
    else
      Map("n", "<leader>lf", function()
        notify_unsupported_lsp "LSP does not support show formatting"
      end, opts)
    end

    if capabilities.signatureHelpProvider then
      Map("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
    else
      Map("n", "<leader>ls", function()
        notify_unsupported_lsp "LSP does not support signature help"
      end, opts)
    end

    if capabilities.codeActionProvider then
      Map("n", "<leader>lca", vim.lsp.buf.code_action, opts)
      Map("v", "<leader>lca", vim.lsp.buf.range_code_action, opts)
    else
      Map({ "n", "v" }, "<leader>lca", function()
        notify_unsupported_lsp "LSP does not support code actions"
      end, opts)
    end

    if capabilities.hoverProvider then
      Map("n", "K", vim.lsp.buf.hover, opts)
    else
      Map("n", "K", function()
        notify_unsupported_lsp "LSP does not support hover information"
      end, opts)
    end

    -- Set autocommands conditional on server_capabilities
    if capabilities.documentHighlightProvider then
      local lsp_highlight_au = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
      vim.api.nvim_create_autocmd({ "CursorHold" }, {
        group = lsp_highlight_au,
        buffer = 0,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved" }, {
        group = lsp_highlight_au,
        buffer = 0,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if capabilities.documentSymbolProvider then
      Map("n", "<leader>lts", ":Telescope lsp_document_symbols<CR>", { silent = true })
    else
      Map("n", "<leader>lts", function()
        notify_unsupported_lsp "LSP does not support showing document symbols"
      end, { silent = true })
    end

    if capabilities.workspaceSymbolProvider then
      Map("n", "<leader>ltS", ":Telescope lsp_workspace_symbols<CR>", { silent = true })
    else
      Map("n", "<leader>ltS", function()
        notify_unsupported_lsp "LSP does not support showing workspace symbols"
      end, { silent = true })
    end

    if capabilities.referencesProvider then
      Map("n", "<leader>ltr", ":Telescope lsp_references<CR>", { silent = true })
    else
      Map("n", "<leader>ltr", function()
        notify_unsupported_lsp "LSP does not support showing references"
      end, { silent = true })
    end

    if capabilities.implementationProvider then
      Map("n", "<leader>lti", ":Telescope lsp_implementations<CR>", { silent = true })
    else
      Map("n", "<leader>lti", function()
        notify_unsupported_lsp "LSP does not support showing implementations"
      end, { silent = true })
    end

    Map("n", "<leader>lci", vim.lsp.buf.incoming_calls, opts)
    Map("n", "<leader>lco", vim.lsp.buf.outgoing_calls, opts)
    local float_opts = { scope = "l", source = "if_many" }
    Map("n", "<leader>ll", function()
      vim.diagnostic.open_float(float_opts)
    end, opts)
    Map("n", "<leader>lj", function()
      vim.diagnostic.goto_next { float = float_opts }
    end, opts)
    Map("n", "<leader>lk", function()
      vim.diagnostic.goto_prev { float = float_opts }
    end, opts)
  end

  L("which-key", function(wk)
    wk.register({
      l = {
        name = "+language",
        c = {
          name = "+code",
          a = { "Code Action" },
          i = { "Incoming Calls" },
          o = { "Outgoing Calls" },
        },
        d = { "Jump to Definition" },
        f = { "Format" },
        j = { "Next Diagnostic" },
        k = { "Previous Diagnostic" },
        l = { "Line Diagnostics" },
        r = { "Rename" },
        s = { "Show Signature Help" },
        t = {
          name = "+finder",
          d = { "Show Diagnostics (Current Buffer)" },
          i = { "Implementations" },
          r = { "References" },
          s = { "Document Symbols" },
          D = { "Implementations" },
          S = { "Show Diagnostics" },
        },
        D = { "Jump to Declaration" },
        T = { "Jump to Type Definition" },
      },
      K = { "Show Documentation" },
    }, { prefix = "<leader>" })
  end)

  -- Make runtime files discoverable to the server
  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  local servers = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
    ansiblels = {},
    bashls = {},
    clangd = {
      filetypes = { "c", "cc", "cpp", "objc", "objcpp" },
    },
    cmake = {},
    cssls = {
      cmd = { "vscode-css-language-server", "--stdio" },
    },
    dockerls = {},
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
    graphql = {},
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
    jsonls = {
      cmd = { "vscode-json-language-server", "--stdio" },
    },
    kotlin_language_server = {},
    metals = {},
    ocamlls = {
      root_dir = nvim_lsp.util.root_pattern(".merlin", "package.json") or nvim_lsp.util.find_git_root,
    },
    pylsp = {},
    rust_analyzer = {
      root_dir = nvim_lsp.util.root_pattern("Cargo.toml", "rust-project.json") or nvim_lsp.util.find_git_root,
    },
    sumneko_lua = {
      cmd = { "lua-language-server" },
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = runtime_path,
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
    svelte = {},
    tailwindcss = {},
    taplo = {},
    texlab = {
      cmd = { "texlab" },
    },
    tsserver = {
      cmd = { "typescript-language-server", "--stdio" },
      root_dir = nvim_lsp.util.find_git_root or nvim_lsp.util.find_node_modules_root,
    },
    vimls = {},
    vuels = {},
    wgsl_analyzer = {},
    yamlls = {},
    zls = {},
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- nvim-cmp supports additional completion capabilities
  L("cmp_nvim_lsp", function(cmp_lsp)
    capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
  end)

  -- overwrite handlers of language server globally
  nvim_lsp.util.default_config = vim.tbl_extend("force", nvim_lsp.util.default_config, {
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = bt,
      }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = bt,
      }),
    },
  })

  for server, config in pairs(servers) do
    config.on_attach = custom_attach
    config.capabilities = capabilities
    nvim_lsp[server].setup(config)
  end

  L("lspconfig.ui.windows").default_options.border = bt
end)
