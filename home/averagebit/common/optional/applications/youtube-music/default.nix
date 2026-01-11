{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [youtube-music];
  home.persistence = {
    "/persist/".directories = [".config/YouTube Music"];
  };
}
