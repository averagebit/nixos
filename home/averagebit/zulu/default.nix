{lib, ...}: {
  imports = [
    ../common/global
    ../common/optional/applications
    ../common/optional/desktops/sway
    ../common/optional/games
    ../common/optional/tools
  ];

  monitors = [
    {
      name = "eDP-1";
      width = 1366;
      height = 768;
      workspace = "1";
      refreshRate = 60;
      primary = true;
    }
  ];

  home.stateVersion = lib.mkDefault "23.11";
}
