{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-web-devicons;
      type = "lua";
      config =
        /*
        lua
        */
        ''
          local devicons = require("nvim-web-devicons")

          devicons.set_icon({
              astro = {
                  --  󱓟 
                  icon = "󱓞",
                  color = "#FF7E33",
                  name = "astro",
              },
          })
        '';
    }
  ];
}
