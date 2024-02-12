{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    yubikey-manager
    # https://github.com/NixOS/nixpkgs/issues/121121
    pcscliteWithPolkit.out
  ];

  services = {
    pcscd.enable = true;
    udev.packages = with pkgs; [yubikey-personalization];
  };
}
