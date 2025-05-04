{lib, ...}: {
  imports = [
    ../common/global
    ../common/optional/applications
    ../common/optional/desktops/sway
    ../common/optional/games
  ];

  home.stateVersion = lib.mkDefault "23.11";
}
