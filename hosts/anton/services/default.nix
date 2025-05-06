{
  imports = [
    ../../common/optional/mysql.nix
    ../../common/optional/nginx.nix

    ./jellyfin
    ./minecraft
    ./playground
    ./prometheus
    ./valheim
  ];
}
