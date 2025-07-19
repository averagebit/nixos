{lib, ...}: {
  imports = [
    ../common/global
    ../common/optional/applications
    ../common/optional/desktops/sway
    ../common/optional/tools
  ];

  monitors = [
    {
      name = "DP-1";
      width = 1680;
      height = 1050;
      workspace = "1";
      refreshRate = 60;
      primary = true;
    }
  ];

  home.stateVersion = lib.mkDefault "24.11";
}
