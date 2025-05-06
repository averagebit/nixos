{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [jellyfin-media-player];
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [
      ".config/jellyfin.org"
    ];
  };
}
