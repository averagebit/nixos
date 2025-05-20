{
  imports = [
    ../../common/optional/mysql.nix
    ../../common/optional/nginx.nix

    ./audiobookshelf
    ./deluge
    ./forgejo
    ./grafana
    ./jellyfin
    ./minecraft
    ./playground
    ./prometheus
    ./valheim
  ];
}
