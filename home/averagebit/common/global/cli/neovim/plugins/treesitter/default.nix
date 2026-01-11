{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-treesitter.withAllGrammars;
      type = "lua";
      config =
        /*
        lua
        */
        ''
          require('nvim-treesitter').setup{}
        '';
    }
  ];
}
