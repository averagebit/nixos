{
  imports = [
    # ../../common/optional/mysql.nix
    ../../common/optional/postgres.nix
    ../../common/optional/nginx.nix

    ./actual
    ./audiobookshelf
    ./authelia
    ./bazarr
    ./blocky
    ./deluge
    ./forgejo
    ./grafana
    ./home-assistant
    ./jellyfin
    ./jellyseerr
    ./lidarr
    ./minecraft
    ./playground
    ./prometheus
    ./prowlarr
    ./radarr
    ./recyclarr
    ./sabnzbd
    ./sonarr
    ./unifi
    ./valheim
    ./vaultwarden
  ];
}
