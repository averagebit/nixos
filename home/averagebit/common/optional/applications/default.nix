{pkgs, ...}: {
  imports = [
    ./carla
    ./chrome
    ./discord
    ./easyeffects
    ./qjackctl
    ./reaper
  ];

  home.packages = with pkgs; [
    yubioath-flutter
    vlc
    vial
  ];
}
