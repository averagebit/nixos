{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [signal-desktop];
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [".config/Signal"];
  };
}
