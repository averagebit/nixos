{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [reaper];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [
      ".local/share/daw"
      ".config/REAPER"
    ];
  };
}
