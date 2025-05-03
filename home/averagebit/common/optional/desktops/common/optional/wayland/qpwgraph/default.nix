{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [qpwgraph];
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [".config/rncbc.org"];
  };
}
