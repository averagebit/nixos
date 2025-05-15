{
  imports = [
    ../../common/optional/mysql.nix
    ../../common/optional/nginx.nix

    ./audiobookshelf
    ./deluge
    # ./file-server
    ./grafana
    ./jellyfin
    ./minecraft
    ./playground
    ./prometheus
    ./valheim
  ];
}
