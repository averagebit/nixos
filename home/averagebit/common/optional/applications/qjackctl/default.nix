{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [qjackctl];
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [".config/rncbc.org"];
  };
}
