{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = mason-nvim;
      type = "lua";
      config =
        /*
        lua
        */
        ''
          require("mason").setup({
            ui = {
              icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
              }
            }
          })
        '';
    }
    {
      plugin = mason-lspconfig-nvim;
      type = "lua";
      config =
        /*
        lua
        */
        ''
          local servers = {
            "ansiblels",
            "astro",
            "bashls",
            "clangd",
            "cssls",
            "dagger",
            "diagnosticls",
            "dockerls",
            "emmet_ls",
            "eslint",
            "gopls",
            "graphql",
            "html",
            "jsonls",
            "lua_ls",
            "marksman",
            "prismals",
            "sqlls",
            "tailwindcss",
            "terraformls",
            "texlab",
            "ts_ls",
            "vimls",
            "yamlls",
          }
          require("mason-lspconfig").setup({
            ensure_installed = servers,
          })
        '';
    }
  ];
}
