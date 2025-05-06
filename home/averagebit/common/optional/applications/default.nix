{pkgs, ...}: {
  imports = [
    ./chrome
    ./daw
    ./deluge
    ./discord
    ./jellyfin
    ./ledger
    ./obs
    ./obsidian
    ./qjackctl
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
