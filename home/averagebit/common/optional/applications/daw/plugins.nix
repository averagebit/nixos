{
  lib,
  pkgs,
  ...
}: {
  home.sessionVariables = let
    makePluginPath = format:
      (lib.makeSearchPath format [
        "$HOME/.nix-profile/lib"
        "/run/current-system/sw/lib"
        "/etc/profiles/per-user/$USER/lib"
      ])
      + ":$HOME/.${format}";
  in {
    DSSI_PATH = makePluginPath "dssi";
    LADSPA_PATH = makePluginPath "ladspa";
    LV2_PATH = makePluginPath "lv2";
    LXVST_PATH = makePluginPath "lxvst";
    VST_PATH = makePluginPath "vst";
    VST3_PATH = makePluginPath "vst3";
  };
  home.packages = with pkgs; [
    calf
    chow-centaur
    chow-kick
    chow-phaser
    chow-tape-model
    guitarix
    gxplugins-lv2
    neural-amp-modeler-lv2
    odin2
    plugdata
    proteus
    surge-XT
    tamgamp.lv2
    vital
    zam-plugins
  ];
}
