{config, ...}:
with config.colorscheme; {
  services.mako = {
    enable = true;
    iconPath = "${config.gtk.iconTheme.package}/share/icons/Papirus-Dark";
    font = "sans-serif 14";
    padding = "10,20";
    anchor = "top-right";
    width = 400;
    height = 150;
    borderSize = 1;
    defaultTimeout = 12000;
    backgroundColor = "#${colors.base00}dd";
    borderColor = "#${colors.base02}dd";
    textColor = "#${colors.base05}dd";
    layer = "overlay";
  };
}
