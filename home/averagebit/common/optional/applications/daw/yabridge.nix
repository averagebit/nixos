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
      "/persist/".directories = [
        ".config/yabridge"
        ".config/yabridgectl"
        ".local/share/wine"
        ".vst"
        ".vst3"
      ];
    };
  };
}
