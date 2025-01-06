{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    (yabridge.override {wine = wineWowPackages.waylandFull;})
    (yabridgectl.override {wine = wineWowPackages.waylandFull;})
  ];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [
      ".config/yabridge"
      ".config/yabridgectl"
      ".local/share/yabridge"
      ".vst3"
    ];
  };
}
