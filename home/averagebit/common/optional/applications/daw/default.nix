{
  config,
  pkgs,
  ...
}: {
  imports = [./plugins.nix ./yabridge.nix];
  home.packages = with pkgs; [reaper];
  home.persistence = {
    "/persist/".directories = [
      ".local/share/daw"
      ".config/REAPER"
    ];
  };
}
