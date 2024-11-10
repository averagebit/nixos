{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [signal-desktop];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/Signal"];
  };
}
