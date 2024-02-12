{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [easyeffects];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/easyeffects"];
  };
}
