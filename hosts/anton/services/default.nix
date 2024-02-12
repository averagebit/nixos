{
  imports = [
    ../../common/optional/mysql.nix
    ../../common/optional/nginx.nix

    ./prometheus
    ./minecraft
    ./factorio
  ];
}
