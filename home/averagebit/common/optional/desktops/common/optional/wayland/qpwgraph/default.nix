{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [qpwgraph];
  home.persistence = {
    "/persist/".directories = [".config/rncbc.org"];
  };
}
