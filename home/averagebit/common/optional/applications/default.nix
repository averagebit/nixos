{pkgs, ...}: {
  imports = [
    ./bottles
    ./carla
    ./chrome
    ./discord
    ./easyeffects
    ./qjackctl
    ./reaper
    ./slack
    ./virt-manager
    ./vscode
  ];

  home.packages = with pkgs; [
    tagger
    vial
    vlc
    yubioath-flutter
  ];
}
