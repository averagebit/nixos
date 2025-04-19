{pkgs, ...}: {
  imports = [
    ./fuzzel
    ./mako
    ./pipewire
    ./qpwgraph
    ./swayidle
    ./swaylock
    ./waybar
    ./zathura
  ];

  home.packages = with pkgs; [
    brightnessctl # Brightness management
    grim # Srceenshots
    pavucontrol # Volume management
    slurp # Srceenshots
    wev # Event viewer
    wl-clipboard # Clipboard
    wlr-randr # Monitor settings
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-wlr];
}
