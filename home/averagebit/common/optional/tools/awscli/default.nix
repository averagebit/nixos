{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [awscli2];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/aws"];
  };
}
