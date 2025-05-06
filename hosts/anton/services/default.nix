{
  imports = [
    ../../common/optional/mysql.nix
    ../../common/optional/nginx.nix

    ./file-server
    ./jellyfin
    ./minecraft
    ./playground
    ./prometheus
    ./valheim
  ];
}
