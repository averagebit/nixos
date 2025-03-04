{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      yabridge
      yabridgectl
      wineWowPackages.staging
    ];
    sessionVariables = {
      WINEPREFIX = "/home/${config.home.username}/.local/share/wine/default";
    };
    persistence = {
      "/persist/home/${config.home.username}".directories = [
        ".config/yabridge"
        ".config/yabridgectl"
        ".local/share/wine"
        ".vst3"
      ];
    };
  };
}
