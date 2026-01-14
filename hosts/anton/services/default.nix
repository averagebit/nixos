{
  imports = [
    # ../../common/optional/mysql.nix
    ../../common/optional/postgres.nix
    ../../common/optional/nginx.nix

    ./audiobookshelf
    ./bazarr
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
  ];
}
