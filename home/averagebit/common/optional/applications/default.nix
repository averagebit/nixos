{pkgs, ...}: {
  imports = [
    ./bottles
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
