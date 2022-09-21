local M = {}

local proto = vim.lsp.protocol
M.get_lsp_capabilities = function(cmp_lsp)
  local capabilities = proto.make_client_capabilities()
  -- nvim-cmp supports additional completion capabilities
  if cmp_lsp then
    capabilities = cmp_lsp.update_capabilities(proto.make_client_capabilities())
  end

  return capabilities
end

local log_lvl = vim.log.levels
local unsupported_title = "LSP Provider not supported"
M.notify_unsupported_lsp = function(message, title)
  vim.notify(message, log_lvl.INFO, { title = title or unsupported_title })
end

M.servers = function(mason)
  local server_configs = {}
  L("lsp_custom", function(custom)
    for lsp, config in pairs(custom) do
      server_configs[lsp] = config or {}
    end
  end)

  if mason then
    for _, v in pairs(mason.get_installed_packages()) do
      if Contains(v.spec.categories, "LSP") then
        if v.name then
          local lsp = M.map[v.name]
          if lsp and not server_configs[lsp] then
            -- adding installed server with default options if not customized
            server_configs[lsp] = {}
          end
        end
      end
    end
  end

  return server_configs
end

M.map = {
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  ["ada-language-server"] = "als",
  ["angular-language-server"] = "angularls",
  ["ansible-language-server"] = "ansiblels",
  ["apex-language-server"] = "apex_ls",
  ["arduino-language-server"] = "arduino_language_server",
  ["asm-lsp"] = "asm_lsp",
  ["astro-language-server"] = "astro",
  ["awk-language-server"] = "awk_ls",
  ["bash-language-server"] = "bashls",
  ["beancount-language-server"] = "beancount",
  ["bicep-lsp"] = "bicep",
  ["bsl-language-server"] = "bsl_ls",
  ["clangd"] = "clangd",
  ["clarity-lsp"] = "clarity_lsp",
  ["clojure-lsp"] = "clojure_lsp",
  ["cmake-language-server"] = "cmake",
  ["codeql"] = "codeqlls",
  ["crystalline"] = "crystalline",
  ["csharp-language-server"] = "csharp_ls",
  ["css-lsp"] = "cssls",
  ["cssmodules-language-server"] = "cssmodules_ls",
  ["cucumber-language-server"] = "cucumber_language_server",
  ["cuelsp"] = "dagger",
  ["deno"] = "denols",
  ["dhall-lsp"] = "dhall_lsp_server",
  ["diagnostic-languageserver"] = "diagnosticls",
  ["dockerfile-language-server"] = "dockerls",
  ["dot-language-server"] = "dotls",
  ["efm"] = "efm",
  ["elixir-ls"] = "elixirls",
  ["elm-language-server"] = "elmls",
  ["ember-language-server"] = "ember",
  ["emmet-ls"] = "emmet_ls",
  ["erlang-ls"] = "erlangls",
  ["esbonio"] = "esbonio",
  ["eslint-lsp"] = "eslint",
  ["flux-lsp"] = "flux_lsp",
  ["foam-language-server"] = "foam_ls",
  ["fortls"] = "fortls",
  ["fsautocomplete"] = "fsautocomplete",
  ["golangci-lint-langserver"] = "golangci_lint_ls",
  ["gopls"] = "gopls",
  ["grammarly-languageserver"] = "grammarly",
  ["graphql-language-service-cli"] = "graphql",
  ["groovy-language-server"] = "groovyls",
  ["haxe-language-server"] = "haxe_language_server",
  ["haskell-language-server"] = "hls",
  ["hoon-language-server"] = "hoon_ls",
  ["html-lsp"] = "html",
  ["intelephense"] = "intelephense",
  ["jdtls"] = "jdtls",
  ["jedi-language-server"] = "jedi_language_server",
  ["json-lsp"] = "jsonls",
  ["jsonnet-language-server"] = "jsonnet_ls",
  ["julia-lsp"] = "julials",
  ["kotlin-language-server"] = "kotlin_language_server",
  ["lelwel"] = "lelwel_ls",
  ["lemminx"] = "lemminx",
  ["ltex-ls"] = "ltex",
  ["luau-lsp"] = "luau_lsp",
  ["marksman"] = "marksman",
  ["metamath-zero-lsp"] = "mm0_ls",
  ["nickel-lang-lsp"] = "nickel_ls",
  ["nimlsp"] = "nimls",
  ["ocaml-lsp"] = "ocamllsp",
  ["omnisharp"] = "omnisharp",
  ["omnisharp-mono"] = "omnisharp_mono",
  ["opencl-language-server"] = "opencl_ls",
  ["perlnavigator"] = "perlnavigator",
  ["phpactor"] = "phpactor",
  ["powershell-editor-services"] = "powershell_es",
  ["prisma-language-server"] = "prismals",
  ["prosemd-lsp"] = "prosemd_lsp",
  ["psalm"] = "psalm",
  ["puppet-editor-services"] = "puppet",
  ["purescript-language-server"] = "purescriptls",
  ["python-lsp-server"] = "pylsp",
  ["pyright"] = "pyright",
  ["quick-lint-js"] = "quick_lint_js",
  ["r-languageserver"] = "r_language_server",
  ["reason-language-server"] = "reason_ls",
  ["remark-language-server"] = "remark_ls",
  ["rescript-lsp"] = "rescriptls",
  ["rnix-lsp"] = "rnix",
  ["robotframework-lsp"] = "robotframework_ls",
  ["rome"] = "rome",
  ["rust-analyzer"] = "rust_analyzer",
  ["salt-lsp"] = "salt_ls",
  ["serve-d"] = "serve_d",
  ["slint-lsp"] = "slint_lsp",
  ["solang"] = "solang",
  ["solargraph"] = "solargraph",
  ["solidity"] = "solc",
  ["sorbet"] = "sorbet",
  ["sourcery"] = "sourcery",
  ["sqlls"] = "sqlls",
  ["sqls"] = "sqls",
  ["stylelint-lsp"] = "stylelint_lsp",
  ["lua-language-server"] = "sumneko_lua",
  ["svelte-language-server"] = "svelte",
  ["svlangserver"] = "svlangserver",
  ["svls"] = "svls",
  ["tailwindcss-language-server"] = "tailwindcss",
  ["taplo"] = "taplo",
  ["teal-language-server"] = "teal_ls",
  ["terraform-ls"] = "terraformls",
  ["texlab"] = "texlab",
  ["tflint"] = "tflint",
  ["shopify-theme-check"] = "theme_check",
  ["typescript-language-server"] = "tsserver",
  ["vala-language-server"] = "vala_ls",
  ["verible"] = "verible",
  ["vim-language-server"] = "vimls",
  ["visualforce-language-server"] = "visualforce_ls",
  ["vls"] = "vls",
  ["vue-language-server"] = "volar",
  ["vetur-vls"] = "vuels",
  ["wgsl-analyzer"] = "wgsl_analyzer",
  ["yaml-language-server"] = "yamlls",
  ["zk"] = "zk",
  ["zls"] = "zls",
}

return M
