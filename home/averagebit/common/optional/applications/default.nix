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
    ./slack
    ./spotify
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
