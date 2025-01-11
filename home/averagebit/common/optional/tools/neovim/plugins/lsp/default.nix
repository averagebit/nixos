{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    otter-nvim
    lspkind-nvim
    {
      plugin = nvim-lspconfig;
      type = "lua";
      config =
        /*
        lua
        */
        ''
          local lspconfig = require('lspconfig')
          function add_lsp(server, options)
            if not options["cmd"] then
              options["cmd"] = server["document_config"]["default_config"]["cmd"]
            end
            if not options["capabilities"] then
              options["capabilities"] = {}
            end
            options["capabilities"] = vim.tbl_extend("keep",
              options["capabilities"],
              require("cmp_nvim_lsp").default_capabilities()
            )

            if vim.fn.executable(options["cmd"][1]) == 1 then
              server.setup(options)
            end
          end

          add_lsp(lspconfig.bashls, {})
          add_lsp(lspconfig.clangd, {})
          add_lsp(lspconfig.dartls, {})
          add_lsp(lspconfig.dockerls, {})
          add_lsp(lspconfig.gopls, {})
          add_lsp(lspconfig.hls, {})
          add_lsp(lspconfig.jdtls, {})
          add_lsp(lspconfig.kotlin_language_server, {})
          add_lsp(lspconfig.lua_ls, {})
          add_lsp(lspconfig.nixd, { settings = { nixd = {
            formatting = { command = { "alejandra" }}
          }}})
          add_lsp(lspconfig.phpactor, {})
          add_lsp(lspconfig.pylsp, {
            settings = {
              pylsp = {
                plugins = {
                  ruff = {
                    severities = { ["F401"] = "W" }
                  }
                }
              }
            },
            capabilities = {
              experimental = {
                inlayHintProvider = true,
              }
            }
          })
          add_lsp(lspconfig.solargraph, {})
          add_lsp(lspconfig.terraformls, {})
          add_lsp(lspconfig.texlab, { chktex = {
            onEdit = true,
            onOpenAndSave = true
          }})
          add_lsp(lspconfig.ts_ls, {})
          add_lsp(lspconfig.tinymist, {})
          add_lsp(lspconfig.elixirls, {cmd = {"elixir-ls"}})
        '';
    }
    {
      plugin = rust-tools-nvim;
      type = "lua";
      config =
        /*
        lua
        */
        ''
          local rust_tools = require('rust-tools')
          add_lsp(rust_tools, {
            cmd = { "rust-analyzer" },
            tools = { autoSetHints = true }
          })
          vim.api.nvim_set_hl(0, '@lsp.type.comment.rust', {})
        '';
    }
  ];
}

