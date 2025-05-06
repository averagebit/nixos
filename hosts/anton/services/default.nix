{
  imports = [
    ../../common/optional/mysql.nix
    ../../common/optional/nginx.nix

    ./deluge
    ./file-server
    ./jellyfin
    ./minecraft
    ./playground
    ./prometheus
    ./valheim
  ];
}
