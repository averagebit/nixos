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

  xdg.portal = {
    extraPortals = [pkgs.inputs.hyprland.xdg-desktop-portal-hyprland];
    # configPackages = [pkgs.inputs.hyprland.hyprland];
    configPackages = [config.wayland.windowManager.hyprland.package];
  };

  home.packages = with pkgs; [inputs.hyprwm-contrib.grimblast hyprpicker];

  wayland.windowManager.hyprland = {
    enable = true;
    package =
      pkgs.inputs.hyprland.hyprland.override {wrapRuntimeDeps = false;};
    systemd = {
      enable = true;
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };

    settings = with config.colorscheme; {
      exec = ["${pkgs.swaybg}/bin/swaybg -i ${config.wallpaper} --mode fill"];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;
        layout = "dwindle";
        resize_on_border = true;
        hover_icon_on_border = true;
        cursor_inactive_timeout = 4;
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
        no_gaps_when_only = true;
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
        drop_shadow = true;
        shadow_range = 12;
        shadow_offset = "3 3";
        "col.shadow" = "0x44000000";
        "col.shadow_inactive" = "0x66000000";
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

      bindm = [
        "SUPER,mouse:272,movewindow"
        "SUPER,mouse:273,resizewindow"
      ];

      bind = let
        makoctl = "${config.services.mako.package}/bin/makoctl";
        playerctl = "${config.services.playerctld.package}/bin/playerctl";
        playerctld = "${config.services.playerctld.package}/bin/playerctld";
        swaylock = "${config.programs.swaylock.package}/bin/swaylock";

        brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
        explorer = "${pkgs.xfce.thunar}/bin/thunar";
        grimblast = "${pkgs.inputs.hyprwm-contrib.grimblast}/bin/grimblast";
        hyprctl = "${pkgs.inputs.hyprland.hyprland}/bin/hyprctl}";
        hyprpicker = "${pkgs.hyprpicker}/bin/hyprpicker";
        menu = "${pkgs.fuzzel}/bin/fuzzel";
        terminal = "${pkgs.foot}/bin/foot";
        wpctl = "${pkgs.wireplumber}/bin/wpctl";
      in
        [
          "SUPERSHIFT,E,exit,"
          "SUPERSHIFT,Q,killactive,"

          "SUPER,S,togglesplit"
          "SUPER,F,fullscreen"
          "SUPERSHIFT,SPACE,togglefloating"

          "SUPER,MINUS,splitratio,-0.25"
          "SUPERSHIFT,MINUS,splitratio,-0.3333333"

          "SUPER,EQUAL,splitratio,0.25"
          "SUPERSHIFT,EQUAL,splitratio,0.3333333"

          "SUPER,G,togglegroup"
          "SUPER,T,lockactivegroup,toggle"
          "SUPER,APOSTROPHE,changegroupactive,f"
          "SUPERSHIFT,APOSTROPHE,changegroupactive,b"

          "SUPER,U,togglespecialworkspace"
          "SUPERSHIFT,U,movetoworkspacesilent,special"

          "SUPER,LEFT,movefocus,l"
          "SUPER,RIGHT,movefocus,r"
          "SUPER,UP,movefocus,u"
          "SUPER,DOWN,movefocus,d"

          "SUPERSHIFT,LEFT,movewindow,l"
          "SUPERSHIFT,RIGHT,movewindow,r"
          "SUPERSHIFT,UP,movewindow,u"
          "SUPERSHIFT,DOWN,movewindow,d"

          "SUPER,1,workspace,1"
          "SUPER,2,workspace,2"
          "SUPER,3,workspace,3"
          "SUPER,4,workspace,4"
          "SUPER,5,workspace,5"
          "SUPER,6,workspace,6"
          "SUPER,7,workspace,7"
          "SUPER,8,workspace,8"
          "SUPER,9,workspace,9"
          "SUPER,0,workspace,10"
          "SUPER,F1,workspace,11"
          "SUPER,F2,workspace,12"
          "SUPER,F3,workspace,13"
          "SUPER,F4,workspace,14"
          "SUPER,F5,workspace,15"
          "SUPER,F6,workspace,16"
          "SUPER,F7,workspace,17"
          "SUPER,F8,workspace,18"
          "SUPER,F9,workspace,19"
          "SUPER,F10,workspace,20"

          "SUPERSHIFT,1,movetoworkspacesilent,1"
          "SUPERSHIFT,2,movetoworkspacesilent,2"
          "SUPERSHIFT,3,movetoworkspacesilent,3"
          "SUPERSHIFT,4,movetoworkspacesilent,4"
          "SUPERSHIFT,5,movetoworkspacesilent,5"
          "SUPERSHIFT,6,movetoworkspacesilent,6"
          "SUPERSHIFT,7,movetoworkspacesilent,7"
          "SUPERSHIFT,8,movetoworkspacesilent,8"
          "SUPERSHIFT,9,movetoworkspacesilent,9"
          "SUPERSHIFT,0,movetoworkspacesilent,10"
          "SUPERSHIFT,F1,movetoworkspacesilent,11"
          "SUPERSHIFT,F2,movetoworkspacesilent,12"
          "SUPERSHIFT,F3,movetoworkspacesilent,13"
          "SUPERSHIFT,F4,movetoworkspacesilent,14"
          "SUPERSHIFT,F5,movetoworkspacesilent,15"
          "SUPERSHIFT,F6,movetoworkspacesilent,16"
          "SUPERSHIFT,F7,movetoworkspacesilent,17"
          "SUPERSHIFT,F8,movetoworkspacesilent,18"
          "SUPERSHIFT,F9,movetoworkspacesilent,19"
          "SUPERSHIFT,F10,movetoworkspacesilent,20"

          # Applications
          "SUPER,Return,exec,${terminal}"
          "SUPER,E,exec, ${explorer}"
          "SUPER,D,exec, pkill fuzzel || ${menu}"
          "SUPER,c,exec,${hyprpicker} -a"
          "SUPERSHIFT,C,exec,${hyprctl} reload"

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
        # Media control
        ++ (lib.optionals config.services.playerctld.enable [
          ",XF86AudioNext,exec,${playerctl} next"
          ",XF86AudioPrev,exec,${playerctl} previous"
          ",XF86AudioPlay,exec,${playerctl} play-pause"
          ",XF86AudioStop,exec,${playerctl} stop"
          "ALT,XF86AudioNext,exec,${playerctld} shift"
          "ALT,XF86AudioPrev,exec,${playerctld} unshift"
          "ALT,XF86AudioPlay,exec,systemctl --user restart playerctld"
        ])
        # Lock screen
        ++ (lib.optionals config.programs.swaylock.enable
          ["SUPER,L,exec,${swaylock}"])
        # Notifications
        ++ (lib.optionals config.services.mako.enable
          ["SUPER,W,exec,${makoctl} dismiss"]);
    };

    extraConfig = ''
      # Resize
      bind=SUPER,R,submap,Resize
      submap=Resize
      binde=,DOWN,resizeactive,0 10
      binde=,LEFT,resizeactive,-10 0
      binde=,RIGHT,resizeactive,10 0
      binde=,UP,resizeactive,0 -10
      bind=,ESCAPE,submap,reset
      submap=reset

      # Passthrough
      bind=SUPER,Z,submap,Passthrough
      submap=Passthrough
      bind=SUPER,Z,submap,reset
      submap=reset
    '';
  };
}
