{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [prismlauncher];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".local/share/PrismLauncher"];
  };
}
