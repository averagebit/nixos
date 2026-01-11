{
  imports = [
    ../../common/optional/mysql.nix
    # ../../common/optional/postgres.nix
    ../../common/optional/nginx.nix

    ./audiobookshelf
    ./deluge
    ./forgejo
    ./grafana
    ./home-assistant
    ./jellyfin
    ./minecraft
    ./navidrome
    ./playground
    ./prometheus
    ./unifi
    ./valheim
  ];
}
