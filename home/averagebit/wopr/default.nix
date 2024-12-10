{lib, ...}: {
  imports = [
    ../common/global
    ../common/optional/applications
    ../common/optional/desktops/hyprland
    ../common/optional/games
    ../common/optional/tools
  ];

  home.stateVersion = lib.mkDefault "23.11";
}
