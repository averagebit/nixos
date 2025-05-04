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
          local servers = {
            ansiblels = {},
            astro = {},
            bashls = {},
            ccssmodules_ls = {},
            clangd = {},
            cssls = {},
            dagger = {},
            dartls = {},
            diagnosticls = {},
            dockerls = {},
            emmet_ls = {},
            eslint = {},
            graphql = {},
            html = {},
            jsonls = {},
            lua_ls = {},
            marksman = {},
            prismals = {},
            sqlls = {},
            tailwindcss = {},
            terraformls = {},
            texlab = {},
            ts_ls = {},
            vimls = {},
            yamlls = {},
            gopls = {},
            nixd = {},
          }

          for server, settings in pairs(servers) do
            local options = vim.tbl_deep_extend("force", {
              on_attach = function(client, bufnr)
              end
            }, settings)

            vim.lsp.enable(server)
            vim.lsp.config(server, options)
          end
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
          rust_tools.setup({
            server = {
              cmd = { "rust-analyzer" },
              tools = { autoSetHints = true }
            }
          })
          vim.api.nvim_set_hl(0, '@lsp.type.comment.rust', {})
        '';
    }
  ];
}
