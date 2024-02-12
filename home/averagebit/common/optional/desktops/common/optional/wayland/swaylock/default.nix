{config, ...}: {
  programs.swaylock = {
    enable = true;
    settings = with config.colorscheme; {
      image = "$HOME/.local/share/wallpapers/lock-dark.png";
      font = "sans-serif";
      font-size = 16;

      disable-caps-lock-text = true;
      indicator-caps-lock = true;
      indicator-idle-visible = false;
      line-uses-inside = true;
      indicator-radius = 50;
      indicator-thickness = 20;

      ring-color = "#${colors.base00}";
      inside-wrong-color = "#${colors.base08}";
      ring-wrong-color = "#${colors.base08}";
      key-hl-color = "#${colors.base0D}";
      bs-hl-color = "#${colors.base08}";
      ring-ver-color = "#${colors.base00}";
      inside-ver-color = "#${colors.base00}";
      inside-color = "#${colors.base01}";
      text-color = "#${colors.base05}";
      text-clear-color = "#${colors.base05}";
      text-ver-color = "#${colors.base05}";
      text-wrong-color = "#${colors.base01}";
      text-caps-lock-color = "#${colors.base07}";
      inside-clear-color = "#${colors.base00}";
      ring-clear-color = "#${colors.base00}";
      inside-caps-lock-color = "#${colors.base09}";
      ring-caps-lock-color = "#${colors.base02}";
      separator-color = "#${colors.base02}";
    };
  };
}
