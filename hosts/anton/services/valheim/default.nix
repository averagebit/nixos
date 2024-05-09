{
  config,
  pkgs,
  lib,
  ...
}: let
  steam-app = "896660";
in {
  imports = [../steam];

  users.groups.valheim = {};
  users.users.valheim = {
    isSystemUser = true;
    home = "/var/lib/valheim";
    createHome = true;
    homeMode = "750";
    group = "valheim";
  };

  systemd.services.valheim = {
    wantedBy = ["multi-user.target"];

    wants = ["steam@${steam-app}.service"];
    after = ["steam@${steam-app}.service"];

    serviceConfig = {
      Nice = "-5";
      PrivateTmp = true;
      Restart = "always";
      User = "valheim";
      WorkingDirectory = "~";
      ExecStart = lib.escapeShellArgs [
        "/var/lib/steam-app-${steam-app}/valheim_server.x86_64"
        "-nographics"
        "-batchmode"
        # "-crossplay" # This is broken because it looks for "party" shared library in the wrong path.
        "-savedir"
        "/var/lib/valheim/save"
        "-name"
        "Nixheim"
        "-port"
        "2456"
        "-world"
        "Dedicated"
        "-public"
        "0"
        "-backups"
        "0"
      ];
    };
    environment = {
      # LD_LIBRARY_PATH = "/var/lib/steam-app-${steam-app}/linux64:${pkgs.glibc}/lib";
      LD_LIBRARY_PATH = "/var/lib/steam-app-${steam-app}/linux64:${pkgs.libz}/lib:${pkgs.glibc}/lib";
      SteamAppId = "892970";
    };
  };

  environment.persistence."/persist".directories = [
    "/var/lib/valheim"
  ];

  networking.firewall = {
    allowedUDPPorts = [2456, 2457];
  };
}
