local M = {}

local lsp_map = {
    ["als"] = "ada-language-server",
    ["angularls"] = "angular-language-server",
    ["ansiblels"] = "ansible-language-server",
    ["antlersls"] = "antlers-language-server",
    ["apex_ls"] = "apex-language-server",
    ["arduino_language_server"] = "arduino-language-server",
    ["asm_lsp"] = "asm-lsp",
    ["astro"] = "astro-language-server",
    ["awk_ls"] = "awk-language-server",
    ["bashls"] = "bash-language-server",
    ["beancount"] = "beancount-language-server",
    ["bicep"] = "bicep-lsp",
    ["bright_script"] = "brighterscript",
    ["bsl_ls"] = "bsl-language-server",
    ["bufls"] = "buf-language-server",
    ["clangd"] = "clangd",
    ["clarity_lsp"] = "clarity-lsp",
    ["clojure_lsp"] = "clojure-lsp",
    ["cmake"] = "cmake-language-server",
    ["codeqlls"] = "codeql",
    ["crystalline"] = "crystalline",
    ["csharp_ls"] = "csharp-language-server",
    ["cssls"] = "css-lsp",
    ["cssmodules_ls"] = "cssmodules-language-server",
    ["cucumber_language_server"] = "cucumber-language-server",
    ["dagger"] = "cuelsp",
    ["denols"] = "deno",
    ["dhall_lsp_server"] = "dhall-lsp",
    ["diagnosticls"] = "diagnostic-languageserver",
    ["docker_compose_language_service"] = "docker-compose-language-service",
    ["dockerls"] = "dockerfile-language-server",
    ["dotls"] = "dot-language-server",
    ["drools_lsp"] = "drools-lsp",
    ["efm"] = "efm",
    ["elixirls"] = "elixir-ls",
    ["elmls"] = "elm-language-server",
    ["ember"] = "ember-language-server",
    ["emmet_ls"] = "emmet-ls",
    ["erg_language_server"] = "erg-language-server",
    ["erlangls"] = "erlang-ls",
    ["esbonio"] = "esbonio",
    ["eslint"] = "eslint-lsp",
    ["fennel_language_server"] = "fennel-language-server",
    ["flux_lsp"] = "flux-lsp",
    ["foam_ls"] = "foam-language-server",
    ["fortls"] = "fortls",
    ["fsautocomplete"] = "fsautocomplete",
    ["glint"] = "glint",
    ["golangci_lint_ls"] = "golangci-lint-langserver",
    ["gopls"] = "gopls",
    ["gradle_ls"] = "gradle-language-server",
    ["grammarly"] = "grammarly-languageserver",
    ["graphql"] = "graphql-language-service-cli",
    ["groovyls"] = "groovy-language-server",
    ["haxe_language_server"] = "haxe-language-server",
    ["hls"] = "haskell-language-server",
    ["hoon_ls"] = "hoon-language-server",
    ["html"] = "html-lsp",
    ["intelephense"] = "intelephense",
    ["jdtls"] = "jdtls",
    ["jedi_language_server"] = "jedi-language-server",
    ["jsonls"] = "json-lsp",
    ["jsonnet_ls"] = "jsonnet-language-server",
    ["julials"] = "julia-lsp",
    ["kotlin_language_server"] = "kotlin-language-server",
    ["lelwel_ls"] = "lelwel",
    ["lemminx"] = "lemminx",
    ["ltex"] = "ltex-ls",
    ["lua_ls"] = "lua-language-server",
    ["luau_lsp"] = "luau-lsp",
    ["marksman"] = "marksman",
    ["mm0_ls"] = "metamath-zero-lsp",
    ["move_analyzer"] = "move-analyzer",
    ["neocmake"] = "neocmakelsp",
    ["nickel_ls"] = "nickel-lang-lsp",
    ["nil_ls"] = "nil",
    ["nimls"] = "nimlsp",
    ["ocamllsp"] = "ocaml-lsp",
    ["omnisharp"] = "omnisharp",
    ["omnisharp_mono"] = "omnisharp-mono",
    ["opencl_ls"] = "opencl-language-server",
    ["openscad_lsp"] = "openscad-lsp",
    ["perlnavigator"] = "perlnavigator",
    ["phpactor"] = "phpactor",
    ["powershell_es"] = "powershell-editor-services",
    ["prismals"] = "prisma-language-server",
    ["prosemd_lsp"] = "prosemd-lsp",
    ["psalm"] = "psalm",
    ["puppet"] = "puppet-editor-services",
    ["purescriptls"] = "purescript-language-server",
    ["pylsp"] = "python-lsp-server",
    ["pyre"] = "pyre",
    ["pyright"] = "pyright",
    ["quick_lint_js"] = "quick-lint-js",
    ["r_language_server"] = "r-languageserver",
    ["raku_navigator"] = "raku-navigator",
    ["reason_ls"] = "reason-language-server",
    ["remark_ls"] = "remark-language-server",
    ["rescriptls"] = "rescript-lsp",
    ["rnix"] = "rnix-lsp",
    ["robotframework_ls"] = "robotframework-lsp",
    ["rome"] = "rome",
    ["ruby_ls"] = "ruby-lsp",
    ["ruff_lsp"] = "ruff-lsp",
    ["rust_analyzer"] = "rust-analyzer",
    ["salt_ls"] = "salt-lsp",
    ["serve_d"] = "serve-d",
    ["slint_lsp"] = "slint-lsp",
    ["smithy_ls"] = "smithy-language-server",
    ["solang"] = "solang",
    ["solargraph"] = "solargraph",
    ["solc"] = "solidity",
    ["solidity"] = "solidity-ls",
    ["sorbet"] = "sorbet",
    ["sourcery"] = "sourcery",
    ["spectral"] = "spectral-language-server",
    ["sqlls"] = "sqlls",
    ["sqls"] = "sqls",
    ["standardrb"] = "standardrb",
    ["stylelint_lsp"] = "stylelint-lsp",
    ["svelte"] = "svelte-language-server",
    ["svlangserver"] = "svlangserver",
    ["svls"] = "svls",
    ["tailwindcss"] = "tailwindcss-language-server",
    ["taplo"] = "taplo",
    ["teal_ls"] = "teal-language-server",
    ["terraformls"] = "terraform-ls",
    ["texlab"] = "texlab",
    ["tflint"] = "tflint",
    ["theme_check"] = "shopify-theme-check",
    ["tsserver"] = "typescript-language-server",
    ["unocss"] = "unocss-language-server",
    ["vala_ls"] = "vala-language-server",
    ["verible"] = "verible",
    ["veryl_ls"] = "veryl-ls",
    ["vimls"] = "vim-language-server",
    ["visualforce_ls"] = "visualforce-language-server",
    ["vls"] = "vls",
    ["volar"] = "vue-language-server",
    ["vtsls"] = "vtsls",
    ["vuels"] = "vetur-vls",
    ["wgsl_analyzer"] = "wgsl-analyzer",
    ["yamlls"] = "yaml-language-server",
    ["zk"] = "zk",
    ["zls"] = "zls",
}

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
  L("user.lsp", function(custom)
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

local invert = function(tbl)
  local result = {}
  for k, v in pairs(tbl) do
    result[v] = k
  end
  return result
end

M.map = invert(lsp_map)

return M
