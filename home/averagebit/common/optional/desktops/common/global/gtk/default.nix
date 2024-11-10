{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["blue"];
        size = "compact";
        tweaks = ["rimless" "normal"];
        variant = "mocha";
      };
    };
    font = {
      name = "sans-serif";
      # size = 10;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "macOS-BigSur";
      package = pkgs.apple-cursor;
      size = 24;
    };
  };
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
}
