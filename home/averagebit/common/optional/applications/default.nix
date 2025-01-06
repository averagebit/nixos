{pkgs, ...}: {
  imports = [
    ./bottles
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
    ./webcord
    ./youtube-music
    ./zap
  ];

  home.packages = with pkgs; [
    tagger
    vial
    vlc
    yubioath-flutter
  ];
}
