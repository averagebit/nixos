{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [jira-cli-go];
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [".config/.jira"];
  };
}
