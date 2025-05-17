{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common/global
    ../common/optional/wayland
  ];

  home.packages = with pkgs; [
    grimblast
    hyprpicker
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = with config.colorscheme; {
      modifier = "Mod4";
      terminal = "${lib.getExe pkgs.foot}";
      menu = "${lib.getExe pkgs.fuzzel}";
      bars = [];

      startup = [
        {command = "${pkgs.swaybg}/bin/swaybg -i ${config.wallpaper} --mode fill";}
      ];

      output = builtins.listToAttrs (map (monitor: {
          name = monitor.name;
          value =
            if monitor.enabled
            then {
              resolution = "${toString monitor.width}x${toString monitor.height}";
              position = "${toString monitor.positionX} ${toString monitor.positionY}";
            }
            else {
              enable = false;
            };
        })
        config.monitors);

      input = {
        "type:keyboard" = {
          xkb_layout = "us,bg";
          xkb_variant = ",phonetic";
          xkb_options = "grp:shifts_toggle,ctrl:nocaps";
          repeat_rate = "40";
          repeat_delay = "240";
        };
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "-0.5";
        };
        "type:touchpad" = {
          natural_scroll = "false";
          accel_profile = "flat";
          pointer_accel = "-0.1";
        };
      };

      fonts = {
        names = ["pango:sens-serif"];
        style = "Regular";
        size = 11.0;
      };

      gaps = {
        inner = 5;
        horizontal = 5;
        smartBorders = "on";
        smartGaps = true;
      };

      floating = {
        border = 1;
        titlebar = false;
      };

      window = {
        border = 1;
        titlebar = false;
      };

      colors = {
        focused = {
          background = "#${colors.base00}";
          border = "#${colors.base0D}";
          childBorder = "#${colors.base0D}";
          indicator = "#${colors.base04}";
          text = "#${colors.base05}";
        };
        unfocused = {
          background = "#${colors.base00}";
          border = "#${colors.base04}";
          childBorder = "#${colors.base04}";
          indicator = "#${colors.base04}";
          text = "#${colors.base05}";
        };
      };

      keybindings = let
        brightnessctl = lib.getExe pkgs.brightnessctl;
        explorer = lib.getExe pkgs.xfce.thunar;
        grim = lib.getExe pkgs.grim;
        hyprpicker = lib.getExe pkgs.hyprpicker;
        makoctl = lib.getExe config.services.mako.package;
        menu = lib.getExe pkgs.fuzzel;
        modifier = config.wayland.windowManager.sway.config.modifier;
        playerctl = lib.getExe' config.services.playerctld.package "playerctl";
        playerctld = lib.getExe' config.services.playerctld.package "playerctld";
        slurp = lib.getExe pkgs.slurp;
        # swaylock = lib.getExe config.programs.swaylock.package;
        terminal = lib.getExe pkgs.foot;
        wpctl = lib.getExe' pkgs.wireplumber "wpctl";
      in {
        # Applications
        "${modifier}+Shift+q" = "kill";
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+d" = "exec ${menu}";
        "${modifier}+e" = "exec ${explorer}";
        "${modifier}+c" = "exec ${hyprpicker} -a";
        # "${modifier}+l" = "exec ${swaylock}";
        "${modifier}+w" = "exec ${makoctl} dismiss";

        # Brightness
        "XF86MonBrightnessDown" = "exec ${brightnessctl} set -5%";
        "XF86MonBrightnessUP" = "exec ${brightnessctl} set +5%";

        # Volume
        "XF86AudioMute" = "exec ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute" = "exec ${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        "XF86AudioLowerVolume" = "exec ${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioRaiseVolume" = "exec ${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";

        # Music
        "XF86AudioNext" = "exec ${playerctl} next";
        "XF86AudioPrev" = "exec ${playerctl} previous";
        "XF86AudioPlay" = "exec ${playerctl} play-pause";
        "XF86AudioStop" = "exec ${playerctl} stop";
        "ALT+XF86AudioNext" = "exec ${playerctld} shift";
        "ALT+XF86AudioPrev" = "exec ${playerctld} unshift";
        "ALT+XF86AudioPlay" = "exec systemctl --user restart playerctld";

        # Screenshots
        "${modifier}+p" = "exec ${grim} -g \"$(${slurp})\" - | wl-copy";

        # Focus window in {direction}
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        # Move focused window in {direction}
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        # Switch to {workspace}
        "${modifier}+1" = "workspace 1";
        "${modifier}+2" = "workspace 2";
        "${modifier}+3" = "workspace 3";
        "${modifier}+4" = "workspace 4";
        "${modifier}+5" = "workspace 5";
        "${modifier}+6" = "workspace 6";
        "${modifier}+7" = "workspace 7";
        "${modifier}+8" = "workspace 8";
        "${modifier}+9" = "workspace 9";
        "${modifier}+0" = "workspace 10";
        "${modifier}+F1" = "workspace 11";
        "${modifier}+F2" = "workspace 12";
        "${modifier}+F3" = "workspace 13";
        "${modifier}+F4" = "workspace 14";
        "${modifier}+F5" = "workspace 15";
        "${modifier}+F6" = "workspace 16";
        "${modifier}+F7" = "workspace 17";
        "${modifier}+F8" = "workspace 18";
        "${modifier}+F9" = "workspace 19";
        "${modifier}+F10" = "workspace 20";

        # Move focused container to {workspace}
        "${modifier}+Shift+1" = "move container to workspace 1";
        "${modifier}+Shift+2" = "move container to workspace 2";
        "${modifier}+Shift+3" = "move container to workspace 3";
        "${modifier}+Shift+4" = "move container to workspace 4";
        "${modifier}+Shift+5" = "move container to workspace 5";
        "${modifier}+Shift+6" = "move container to workspace 6";
        "${modifier}+Shift+7" = "move container to workspace 7";
        "${modifier}+Shift+8" = "move container to workspace 8";
        "${modifier}+Shift+9" = "move container to workspace 9";
        "${modifier}+Shift+0" = "move container to workspace 10";
        "${modifier}+Shift+F1" = "move container to workspace 11";
        "${modifier}+Shift+F2" = "move container to workspace 12";
        "${modifier}+Shift+F3" = "move container to workspace 13";
        "${modifier}+Shift+F4" = "move container to workspace 14";
        "${modifier}+Shift+F5" = "move container to workspace 15";
        "${modifier}+Shift+F6" = "move container to workspace 16";
        "${modifier}+Shift+F7" = "move container to workspace 17";
        "${modifier}+Shift+F8" = "move container to workspace 18";
        "${modifier}+Shift+F9" = "move container to workspace 19";
        "${modifier}+Shift+F10" = "move container to workspace 20";

        # Create a horizontal|vertical split
        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";

        # Switch the current container between different layout styles
        # "${modifier}+s" = "layout stacking";
        # "${modifier}+w" = "layout tabbed";
        # "${modifier}+e" = "layout toggle split";

        # Toggle fullscreen for current focus
        "${modifier}+f" = "fullscreen";

        # Toggle the current focus between tiling and floating mode
        "${modifier}+Shift+Space" = "floating toggle";

        # Swap focus between the tiling area and the floating area
        "${modifier}+Space" = "focus mode_toggle";

        # Move focus to the parent container
        "${modifier}+a" = "focus parent";

        # Scratchpad
        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        # Enter rezise mode
        "${modifier}+r" = "mode 'resize'";
      };

      modes = {
        resize = {
          Down = "resize grow height 10 px";
          Escape = "mode default";

          Left = "resize shrink width 10 px";
          Return = "mode default";
          Right = "resize grow width 10 px";
          Up = "resize shrink height 10 px";

          h = "resize grow width 10 px";
          j = "resize grow height 10 px";
          k = "resize shrink height 10 px";
          l = "resize shrink width 10 px";
        };
      };
    };
  };
}
