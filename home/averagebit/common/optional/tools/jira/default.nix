{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [jira-cli-go];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/.jira"];
  };
}
