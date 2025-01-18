{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./plugins.nix];
  home.packages = with pkgs; [ reaper ];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [
      ".local/share/daw"
      ".config/REAPER"
    ];
  };
}
