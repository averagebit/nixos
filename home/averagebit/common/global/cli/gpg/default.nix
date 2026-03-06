{
  config,
  pkgs,
  lib,
  ...
}: {
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = ["202C2696DF698259"];
    enableExtraSocket = true;
    pinentry.package =
      if config.gtk.enable
      then pkgs.pinentry-gnome3
      else pkgs.pinentry-tty;
  };

  home.packages = lib.optional config.gtk.enable pkgs.gcr;

  programs = {
    bash.profileExtra = ''
      gpgconf --launch gpg-agent
    '';

    gpg = {
      enable = true;
      settings = {
        trust-model = "tofu+pgp";
      };
      publicKeys = [
        {
          source = ../../../../pgp.asc;
          trust = 5;
        }
      ];
    };
  };
}
