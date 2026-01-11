{
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
    home = "/srv/valheim";
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
        "-savedir"
        "/srv/valheim/save"
        "-name"
        "Nixheim"
        "-port"
        "2456"
        "-world"
        "Dedicated"
        "-instanceid"
        "nixheim-vanilla"
        "-public"
        "0"
        "-backups"
        "0"
        "-modifier"
        "raids none"
      ];
    };
    environment = {
      LD_LIBRARY_PATH = "/var/lib/steam-app-${steam-app}/linux64:${pkgs.libz}/lib:${pkgs.glibc}/lib";
      SteamAppId = "892970";
    };
  };

  environment.persistence."/persist".directories = [
    "/srv/valheim"
  ];

  networking.firewall = {
    allowedUDPPorts = [2456 2457];
  };
}
