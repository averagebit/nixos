{
  imports = [
    ../../common/optional/mysql.nix
    ../../common/optional/nginx.nix

    ./factorio
    ./jellyfin
    # ./minecraft
    ./prometheus
    ./valheim
  ];
}
