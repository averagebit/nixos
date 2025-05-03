{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [slack];
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [".config/Slack"];
  };
}
