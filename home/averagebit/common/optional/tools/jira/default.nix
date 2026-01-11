{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [jira-cli-go];
  home.persistence = {
    "/persist/".directories = [".config/.jira"];
  };
}
