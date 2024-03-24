{pkgs, ...}: {
  imports = [
    ./bottles
    ./carla
    ./chrome
    ./discord
    ./easyeffects
    ./qjackctl
    ./reaper
    ./virt-manager
    ./vscode
  ];

  home.packages = with pkgs; [
    yubioath-flutter
    vlc
    vial
  ];
}
