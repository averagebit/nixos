{lib, ...}: {
  imports = [
    ../common/global
    ../common/optional/applications
    ../common/optional/desktops/sway
    ../common/optional/games
    ../common/optional/tools
  ];

  home.stateVersion = lib.mkDefault "23.11";
}
