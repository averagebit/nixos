{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [wineWowPackages.waylandFull winetricks];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".local/share/wine"];
  };
}

