{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [audiorelay];
  home.persistence = {
    "/persist/".directories = [
      ".local/share/audiorelay"
      ".cache/audiorelay"
    ];
  };
}
