{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [awscli2];
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [".config/aws"];
  };
}
