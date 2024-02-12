{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [qjackctl];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/rncbc.org"];
  };
}
