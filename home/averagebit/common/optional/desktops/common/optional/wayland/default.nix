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
    # pwvucontrol # Pipewire volume management
    pavucontrol # Volume management
    slurp # Srceenshots
    wev # Event viewer
    wl-clipboard # Clipboard
    wlr-randr # Monitor settings
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;

    XDG_SESSION_TYPE = "wayland";

    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;

    WLR_NO_HARDWARE_CURSORS = 1;
    MOZ_ENABLE_WAYLAND = 1;
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-wlr];
}
