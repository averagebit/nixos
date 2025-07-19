{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [deluge];
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [
      ".config/deluge"
    ];
  };
}
