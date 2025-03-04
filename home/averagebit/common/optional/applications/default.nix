{pkgs, ...}: {
  imports = [
    ./chrome
    ./discord
    ./ledger
    ./obs
    ./obsidian
    ./qjackctl
    ./reaper
    ./signal
    ./slack
    ./spotify
    ./virt-manager
    ./youtube-music
  ];

  home.packages = with pkgs; [
    tagger
    vial
    yubioath-flutter
  ];
}
