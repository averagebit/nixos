{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [slack];
  home.persistence = {
    "/persist/".directories = [".config/Slack"];
  };
}
