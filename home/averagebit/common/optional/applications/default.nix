{pkgs, ...}: {
  imports = [
    ./chrome
    ./discord
    ./easyeffects
    ./obs
    ./obsidian
    ./qjackctl
    ./reaper
    ./signal
    ./slack
    ./spotify
    ./virt-manager
    ./vscode
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
