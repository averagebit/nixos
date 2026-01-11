{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [obs-studio];
  home.persistence = {
    "/persist/".directories = [".config/obs-studio"];
  };
}
