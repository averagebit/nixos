{
  pkgs,
  config,
  lib,
  ...
}: let
  pinentry =
    if config.gtk.enable
    then {
      name = "gnome3";
      packages = with pkgs; [pinentry-gnome gcr];
    }
    else {
      name = "curses";
      packages = with pkgs; [pinentry-curses];
    };
in {
  home.packages = pinentry.packages;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = ["202C2696DF698259"];
    pinentryFlavor = pinentry.name;
    enableExtraSocket = true;
  };

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

  systemd.user.services = {
    link-gnupg-sockets = {
      Unit = {
        Description = "link gnupg sockets from /run to /home";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
        ExecStop = "${pkgs.coreutils}/bin/rm $HOME/.gnupg-sockets";
        RemainAfterExit = true;
      };
      Install.WantedBy = ["default.target"];
    };
  };
}
