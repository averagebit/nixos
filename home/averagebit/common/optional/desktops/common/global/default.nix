{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./firefox
    ./foot
    ./gammastep
    ./gtk
    ./kdeconnect
    ./mpv
    ./playerctl
    ./qt
    ./wallpapers
    ./wireless
  ];

  xdg = {
    enable = true;
    mimeApps.enable = true;
    portal.enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      publicShare = "${config.home.homeDirectory}/public";
      templates = "${config.home.homeDirectory}/templates";
      videos = "${config.home.homeDirectory}/videos";
      extraConfig = {
        SCREENSHOTS = "${config.home.homeDirectory}/pictures/screenshots";
        WORKSPACE = "${config.home.homeDirectory}/workspace";
        REPOS = "${config.home.homeDirectory}/workspace/repos";
      };
    };
  };

  home.packages = with pkgs; [
    xdg-utils # Desktop integration
  ];
}
