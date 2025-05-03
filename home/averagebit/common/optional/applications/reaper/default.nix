{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./plugins.nix];
  home.packages = with pkgs; [reaper];
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [
      ".local/share/daw"
      ".config/REAPER"
    ];
  };
}
