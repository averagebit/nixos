{
  config,
  pkgs,
  ...
}: let
  steam-with-pkgs = pkgs.steam.override {
    extraPkgs = pkgs:
      with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
      ];
  };
in {
  home.packages = with pkgs; [
    gamescope
    protontricks
    sc-controller
    steam-with-pkgs
  ];
  home.persistence = {
    "/persist/home/${config.home.username}" = {
      allowOther = true;
      directories = [
        ".local/share/Steam"
        ".factorio"
        ".config/unity3d/IronGate/Valheim"
        ".local/share/Paradox Interactive"
        ".paradoxlauncher"
        "Zomboid"
      ];
    };
  };
}
