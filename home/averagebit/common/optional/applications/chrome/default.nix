{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [google-chrome];

  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/google-chrome"];
  };
}
