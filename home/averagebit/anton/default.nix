{lib, ...}: {
  imports = [../common/global];

  home.stateVersion = lib.mkDefault "23.11";
}
