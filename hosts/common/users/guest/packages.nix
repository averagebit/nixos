{pkgs, ...}: let
  steam-with-pkgs = pkgs.steam.override {
    extraPkgs = pkgs:
      with pkgs; [
        keyutils
        libkrb5
        libpng
        libpulseaudio
        libvorbis
        libxcursor
        libxi
        libxinerama
        libxscrnsaver
        stdenv.cc.cc.lib
      ];
  };
in {
  users.users.guest.packages = with pkgs; [
    firefox

    gamescope
    lutris
    prismlauncher
    protontricks
    steam-with-pkgs
  ];
}
