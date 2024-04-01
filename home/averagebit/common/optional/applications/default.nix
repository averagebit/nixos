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
    yubioath-flutter
    vlc
    vial
  ];
}
