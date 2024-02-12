{lib, ...}: {
  imports = [
    ../common/global
    ../common/optional/security
    ../common/optional/tools
  ];

  home.stateVersion = lib.mkDefault "23.11";
}
