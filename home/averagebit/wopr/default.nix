{lib, ...}: {
  imports = [
    ../common/global
    ../common/optional/applications
    ../common/optional/desktops/hyprland
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
      position = "0x0";
      primary = true;
    }
    {
      name = "DP-1";
      width = 1680;
      height = 1050;
      workspace = "20";
      refreshRate = 60;
      position = "auto-right";
      enabled = true;
    }
  ];

  home.stateVersion = lib.mkDefault "23.11";
}
