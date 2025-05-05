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
      name = "HDMI-A-2";
      width = 1920;
      height = 1080;
      workspace = "1";
      refreshRate = 100;
      primary = true;
    }
    {
      name = "DP-1";
      width = 1680;
      height = 1050;
      workspace = "20";
      refreshRate = 60;
      positionX = 1920;
      positionY = 0;
      enabled = true;
    }
  ];

  home.stateVersion = lib.mkDefault "23.11";
}
