{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    (yabridgectl.override {wine = wineWowPackages.waylandFull;})
  ];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [
      ".config/yabridge"
      ".config/yabridgectl"
      ".vst3"
    ];
  };
}
