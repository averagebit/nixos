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

  xdg.portal.config.hyprland = {default = ["wlr" "gtk"];};

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
      exec = [
        "${pkgs.swaybg}/bin/swaybg -i ${config.wallpaper} --mode fill"
        "hyprctl setcursor ${config.gtk.cursorTheme.name} ${toString config.gtk.cursorTheme.size}"
      ];

      exec-once = ["hyprctl dispatch workspace 1"];

      monitor =
        map (m: "${m.name},${
          if m.enabled
          then "${toString m.width}x${toString m.height}@${toString m.refreshRate},${toString m.positionX}x${toString m.positionY},1"
          else "disable"
        }")
        config.monitors;

      workspace = map (m: "name:${m.workspace},monitor:${m.name}") (
        lib.filter (m: m.enabled && m.workspace != null) config.monitors
      );

      animations.enabled = false;

      layerrule = ["blur,waybar" "ignorezero,waybar"];

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
        kb_options = "grp:shifts_toggle";
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

      bind = let
        brightnessctl = lib.getExe pkgs.brightnessctl;
        explorer = lib.getExe pkgs.xfce.thunar;
        grimblast = lib.getExe pkgs.grimblast;
        hyprpicker = lib.getExe pkgs.hyprpicker;
        makoctl = lib.getExe config.services.mako.package;
        menu = lib.getExe pkgs.fuzzel;
        playerctld = lib.getExe' config.services.playerctld.package "playerctld";
        playerctl = lib.getExe' config.services.playerctld.package "playerctl";
        swaylock = lib.getExe config.programs.swaylock.package;
        terminal = lib.getExe pkgs.foot;
        wpctl = lib.getExe' pkgs.wireplumber "wpctl";
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
