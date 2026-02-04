{pkgs, ...}: {
  imports = [
    ./audiorelay
    ./chrome
    ./daw
    ./deluge
    ./discord
    ./element
    ./jellyfin
    ./krita
    ./ledger
    ./obs
    ./obsidian
    ./postman
    ./qjackctl
    ./signal
    ./slack
    ./spotify
    ./virt-manager
    # ./youtube-music
  ];

  home.packages = with pkgs; [
    tagger
    vial
    yubioath-flutter
  ];
}
