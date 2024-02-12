{
  # Steam: Right-click game - Properties - Launch options: gamemoderun %command%
  # Lutris: General Preferences - Enable Feral GameMode
  #                             - Global options - Add Environment Variables: LD_PRELOAD=/nix/store/*-gamemode-*-lib/lib/libgamemodeauto.so
  programs = {
    gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
          inhibit_screensaver = 0;
        };
      };
    };
  };
}
