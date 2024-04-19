{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [spotify];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/spotify"];
  };
}
