{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [obs-studio];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/obs-studio"];
  };
}
