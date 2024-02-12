{
  pkgs,
  lib,
  config,
  ...
}: let
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  swaylock = "${config.programs.swaylock.package}/bin/swaylock";
  swaymsg = "${config.wayland.windowManager.sway.package}/bin/swaymsg";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
in {
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    timeouts =
      [
        # Lock screen
        {
          timeout = builtins.floor (6 * 40);
          command = "${swaylock} --daemonize";
        }
        # Mute mic
        {
          timeout = builtins.floor (6 * 42);
          command = "${wpctl} set-mute @DEFAULT_AUDIO_SINK@ 1";
          resumeCommand = "${wpctl} set-mute @DEFAULT_AUDIO_SINK@ 0";
        }
      ]
      ++
      # Turn off displays (hyprland)
      lib.optionals config.wayland.windowManager.hyprland.enable [
        {
          timeout = builtins.floor (4 * 47);
          command = "${hyprctl} dispatch dpms off";
          resumeCommand = "${hyprctl} dispatch dpms on";
        }
      ]
      ++
      # Turn off displays (sway)
      lib.optionals config.wayland.windowManager.sway.enable [
        {
          timeout = builtins.floor (4 * 47);
          command = "${swaymsg} 'output * dpms off'";
          resumeCommand = "${swaymsg} 'output * dpms on'";
        }
      ];
  };
}
