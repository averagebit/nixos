{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = catppuccin-nvim;
      type = "lua";
      config =
        /*
        lua
        */
        ''
          require("catppuccin").setup({
              flavour = "mocha", -- latte, frappe, macchiato, mocha
              background = {
                  light = "latte",
                  dark = "mocha",
              },
              transparent_background = false,
              show_end_of_buffer = false,
              term_colors = false,
              compile = {
                  enabled = true,
                  path = vim.fn.stdpath("cache") .. "/catppuccin",
              },
              integrations = {
                  alpha = true,
                  cmp = true,
                  gitsigns = true,
                  harpoon = true,
                  illuminate = true,
                  nvimtree = true,
                  telescope = true,
                  treesitter = true,
                  treesitter_context = true,
                  which_key = true,
                  -- Special
                  indent_blankline = {
                      enabled = true,
                      color_indent_levels = false,
                  },
                  dap = {
                      enabled = true,
                      enable_ui = true,
                  },
                  native_lsp = {
                      enabled = true,
                      virtual_text = {
                          errors = { "italic" },
                          hints = { "italic" },
                          warnings = { "italic" },
                          information = { "italic" },
                      },
                      underlines = {
                          errors = { "underline" },
                          hints = { "underline" },
                          warnings = { "underline" },
                          information = { "underline" },
                      },
                  },
              },
          })

          vim.cmd "colorscheme catppuccin-mocha"
        '';
    }
  ];
}
