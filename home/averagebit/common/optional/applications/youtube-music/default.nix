{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [youtube-music];
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [".config/YouTube Music"];
  };
}
