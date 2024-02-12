{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      font-awesome
      (nerdfonts.override {fonts = ["Hack" "Noto"];})
    ];

    fontconfig.defaultFonts = {
      serif = ["NotoSerif Nerd Font"];
      sansSerif = ["NotoSans Nerd Font"];
      monospace = ["Hack Nerd Font Mono"];
    };
  };
}
