{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [qpwgraph];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/rncbc.org"];
  };
}
