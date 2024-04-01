{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [slack];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/Slack"];
  };
}
