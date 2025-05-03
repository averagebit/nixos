{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [obs-studio];
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [".config/obs-studio"];
  };
}
