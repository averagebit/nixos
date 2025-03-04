{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common/global
    ../common/optional/wayland
    ./basic-binds.nix
  ];

  xdg.portal = {
    extraPortals = [pkgs.xdg-desktop-portal-wlr];
    config.hyprland = {
      default = ["wlr" "gtk"];
    };
  };

  home.packages = with pkgs; [
    grimblast
    hyprpicker
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;

    systemd = {
      enable = true;
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };

    settings = with config.colorscheme; {
      exec = ["${pkgs.swaybg}/bin/swaybg -i ${config.wallpaper} --mode fill"];

      monitor = ",1680x1050,auto,1";
      # monitor = ",highres@highrr,0x0,1";
      # monitor = ",highres,auto,1";
      # monitor = ",preferred,auto,1";

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;
        layout = "dwindle";
        resize_on_border = true;
        hover_icon_on_border = true;
        "col.active_border" = "0xff${colors.base0D}";
        "col.inactive_border" = "0xff${colors.base02}";
      };

      input = {
        kb_layout = "us,es";
        kb_options = grp:shifts_toggle;
        follow_mouse = 1;
        repeat_rate = 40;
        repeat_delay = 240;
        accel_profile = "flat";
        sensitivity = -0.1;
        touchpad = {
          disable_while_typing = true;
          natural_scroll = false;
          middle_button_emulation = true;
          tap-to-click = false;
          clickfinger_behavior = true;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_distance = 100;
      };

      dwindle = {
        force_split = 2;
        preserve_split = true;
        pseudotile = false;
      };

      misc = {
        background_color = "0x${colors.base01}";
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        focus_on_activate = false;
        key_press_enables_dpms = true;
        mouse_move_enables_dpms = true;
      };

      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];

      windowrulev2 = [
        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
      ];

      layerrule = ["blur,waybar" "ignorezero,waybar"];

      decoration = {
        active_opacity = 0.95;
        fullscreen_opacity = 1.0;
        inactive_opacity = 0.75;
        rounding = 0;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
        };
        shadow = {
          enabled = true;
          offset = "3 3";
          range = 12;
          color = "0x44000000";
          color_inactive = "0x66000000";
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "easein,0.11, 0, 0.5, 0"
          "easeout,0.5, 1, 0.89, 1"
          "easeinback,0.36, 0, 0.66, -0.56"
          "easeoutback,0.34, 1.56, 0.64, 1"
        ];
        animation = [
          "windowsIn,1,2,easeoutback,slide"
          "windowsOut,1,2,easeinback,slide"
          "windowsMove,1,2,easeoutback"
          # "workspaces,1,2,easeoutback,slide"
          "workspaces,0"
          "fadeIn,1,2,easeout"
          "fadeOut,1,2,easein"
          "fadeSwitch,1,2,easeout"
          "fadeShadow,1,2,easeout"
          "fadeDim,1,2,easeout"
          "border,1,2,easeout"
        ];
      };

      bind = let
        makoctl = "${config.services.mako.package}/bin/makoctl";
        playerctl = "${config.services.playerctld.package}/bin/playerctl";
        playerctld = "${config.services.playerctld.package}/bin/playerctld";
        swaylock = "${config.programs.swaylock.package}/bin/swaylock";

        brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
        explorer = "${pkgs.xfce.thunar}/bin/thunar";
        grimblast = "${pkgs.grimblast}/bin/grimblast";
        hyprpicker = "${pkgs.hyprpicker}/bin/hyprpicker";
        menu = "${pkgs.fuzzel}/bin/fuzzel";
        terminal = "${pkgs.foot}/bin/foot";
        wpctl = "${pkgs.wireplumber}/bin/wpctl";
      in
        [
          # Applications
          "SUPER,Return,exec,${terminal}"
          "SUPER,E,exec, ${explorer}"
          "SUPER,D,exec, pkill fuzzel || ${menu}"
          "SUPER,C,exec,${hyprpicker} -a"

          # Brightness
          ",XF86MonBrightnessDown,exec,${brightnessctl} set -5%"
          ",XF86MonBrightnessUP,exec,${brightnessctl} set +5%"

          # Volume
          ",XF86AudioMute,exec,${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute,exec,${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86AudioLowerVolume,exec,${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioRaiseVolume,exec,${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%+"

          # Screenshots
          "ALT,P,exec,${grimblast} --notify --freeze copy active"
          "CONTROL,P,exec,${grimblast} --notify --freeze copy screen"
          "SUPER,P,exec,${grimblast} --notify --freeze copy area"
        ]
        # Lock screen
        ++ (lib.optionals config.programs.swaylock.enable
          ["SUPER,L,exec,${swaylock}"])
        # Notifications
        ++ (lib.optionals config.services.mako.enable
          ["SUPER,W,exec,${makoctl} dismiss"])
        # Media control
        ++ (lib.optionals config.services.playerctld.enable [
          ",XF86AudioNext,exec,${playerctl} next"
          ",XF86AudioPrev,exec,${playerctl} previous"
          ",XF86AudioPlay,exec,${playerctl} play-pause"
          ",XF86AudioStop,exec,${playerctl} stop"
          "ALT,XF86AudioNext,exec,${playerctld} shift"
          "ALT,XF86AudioPrev,exec,${playerctld} unshift"
          "ALT,XF86AudioPlay,exec,systemctl --user restart playerctld"
        ]);
    };
  };
}
