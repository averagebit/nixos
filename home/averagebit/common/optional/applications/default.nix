{pkgs, ...}: {
  imports = [
    ./bottles
    ./carla
    ./chrome
    ./discord
    ./easyeffects
    ./obs
    ./qjackctl
    ./reaper
    ./signal
    ./slack
    ./spotify
    ./virt-manager
    ./vscode
    ./zap
  ];

  home.packages = with pkgs; [
    tagger
    vial
    vlc
    yubioath-flutter
  ];
}
