{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [carla];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/falkTX"];
  };
}
