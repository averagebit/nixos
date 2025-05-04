{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = indent-blankline-nvim;
      type = "lua";
      config =
        /*
        lua
        */
        ''
          require("ibl").setup({
              exclude = {
                filetypes = {
                  "NvimTree",
                  "Trouble",
                  "dashboard",
                  "help",
                  "lazy",
                  "neogitstatus",
                  "packer",
                  "startify",
                  "text",
                },
                buftypes = {
                  "terminal", "nofile"
                },
              },
          })
        '';
    }
  ];
}
