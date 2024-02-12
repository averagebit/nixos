{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [prismlauncher-qt5];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".local/share/PrismLauncher"];
  };
}
