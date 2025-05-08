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
          local wk = require "which-key"
          wk.add {
            { "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Apply code action" },
            { "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix code action" },
            { "<leader>k", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Show documentation for symbol under cursor" },
            { "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename symbol" },
            { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
            { "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Go to prev diagnostic" },
            { "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Go to next diagnostic" },
            { "gD", "<cmd>lua vim.lsp.buf.declaration<cr>", desc = "Go to declaration" },
          }

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
