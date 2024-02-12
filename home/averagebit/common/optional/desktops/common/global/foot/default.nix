{config, ...}: {
  programs = {
    foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "monospace:size=10";
          dpi-aware = "yes";
        };

        mouse.hide-when-typing = "yes";

        colors = with config.colorscheme; {
          alpha = 0.95;
          foreground = "${colors.base05}";
          background = "${colors.base00}";

          regular0 = "${colors.base03}";
          regular1 = "${colors.base08}";
          regular2 = "${colors.base0B}";
          regular3 = "${colors.base0A}";
          regular4 = "${colors.base0D}";
          regular5 = "${colors.base0E}";
          regular6 = "${colors.base0C}";
          regular7 = "${colors.base04}";

          bright0 = "${colors.base04}";
          bright1 = "${colors.base08}";
          bright2 = "${colors.base0B}";
          bright3 = "${colors.base0A}";
          bright4 = "${colors.base0D}";
          bright5 = "${colors.base0E}";
          bright6 = "${colors.base0C}";
          bright7 = "${colors.base04}";
        };
      };
    };
  };
}
