{config, ...}: {
  wallpaper = "${config.home.homeDirectory}/.local/share/wallpapers/wall-dark.png";

  home = {
    file.".local/share/wallpapers/wall-dark.png".source =
      ./mocha-crust-mountain.png;
    file.".local/share/wallpapers/wall-light.png".source =
      ./mocha-text-mountain.png;
    file.".local/share/wallpapers/lock-dark.png".source =
      ./mocha-crust-lock.png;
    file.".local/share/wallpapers/lock-light.png".source =
      ./mocha-text-lock.png;
  };
}
