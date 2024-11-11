{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [zap];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".ZAP"];
  };
}
