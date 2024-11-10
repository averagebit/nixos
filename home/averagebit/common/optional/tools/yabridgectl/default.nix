{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [yabridgectl];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [
      ".config/yabridgectl"
      ".vst3"
    ];
  };
}
