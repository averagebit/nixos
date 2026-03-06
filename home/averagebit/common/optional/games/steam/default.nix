{
  config,
  pkgs,
  lib,
  ...
}: let
  steam-with-pkgs = pkgs.steam.override {
    extraPkgs = pkgs:
      with pkgs; [
        gamescope
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

  monitor = lib.head (lib.filter (m: m.primary) config.monitors);
  steam-session = let
    gamescope = lib.concatStringsSep " " [
      (lib.getExe pkgs.gamescope)
      "--output-width ${toString monitor.width}"
      "--output-height ${toString monitor.height}"
      "--framerate-limit ${toString monitor.refreshRate}"
      "--prefer-output ${monitor.name}"
      "--adaptive-sync"
      "--expose-wayland"
      "--hdr-enabled"
      "--steam"
    ];
    steam = lib.concatStringsSep " " [
      "steam"
      "steam://open/bigpicture"
    ];
  in
    pkgs.writeTextDir "share/wayland-sessions/steam-session.desktop"
    ''
      [Desktop Entry]
      Name=Steam Session
      Exec=${gamescope} -- ${steam}
      Type=Application
    '';
in {
  home.packages = [
    pkgs.gamescope
    pkgs.protontricks
    steam-session
    steam-with-pkgs
  ];
  home.persistence = {
    "/persist/".directories = [
      ".local/share/Steam"
      ".factorio"
      ".config/unity3d/IronGate/Valheim"
      ".local/share/Paradox Interactive"
      ".paradoxlauncher"
      "Zomboid"
    ];
  };
}
