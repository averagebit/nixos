{pkgs, ...}: {
  imports = [
    ./bottles
    ./carla
    ./chrome
    ./discord
    ./easyeffects
    ./qjackctl
    ./reaper
    ./vscode
  ];

  home.packages = with pkgs; [
    yubioath-flutter
    vlc
    vial
  ];
}
