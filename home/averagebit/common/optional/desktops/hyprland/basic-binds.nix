{lib, ...}: {
  wayland.windowManager.hyprland = {
    settings = {
      bindm = [
        "SUPER,mouse:272,movewindow"
        "SUPER,mouse:273,resizewindow"
      ];

      bind = let
        workspaces = [
          "1"
          "2"
          "3"
          "4"
          "5"
          "6"
          "7"
          "8"
          "9"
          "0"
          "F1"
          "F2"
          "F3"
          "F4"
          "F5"
          "F6"
          "F7"
          "F8"
          "F9"
          "F10"
        ];
        directions = rec {
          left = "l";
          right = "r";
          up = "u";
          down = "d";
          h = left;
          l = right;
          k = up;
          j = down;
        };
      in
        [
          "SUPERSHIFT,E,exit"
          "SUPERSHIFT,Q,killactive"

          "SUPER,S,togglesplit"
          "SUPER,F,fullscreen,1"
          "SUPERSHIFT,F,fullscreen,0"
          "SUPERSHIFT,SPACE,togglefloating"

          "SUPER,MINUS,splitratio,-0.25"
          "SUPERSHIFT,MINUS,splitratio,-0.3333333"

          "SUPER,EQUAL,splitratio,0.25"
          "SUPERSHIFT,EQUAL,splitratio,0.3333333"

          "SUPER,U,togglespecialworkspace"
          "SUPERSHIFT,U,movetoworkspacesilent,special"
          "SUPER,I,pseudo"
        ]
        ++
        # Change workspace
        (lib.lists.imap1 (i: v: "SUPER,${v},workspace,name:${toString i}") workspaces)
        ++
        # Move window to workspace
        (lib.lists.imap1 (i: v: "SUPERSHIFT,${v},movetoworkspacesilent,name:${toString i}") workspaces)
        ++
        # Move focus
        (lib.mapAttrsToList (key: direction: "SUPER,${key},movefocus,${direction}") directions)
        ++
        # Move windows
        (lib.mapAttrsToList (key: direction: "SUPERSHIFT,${key},movewindow,${direction}") directions)
        ++
        # Swap windows
        (lib.mapAttrsToList (key: direction: "SUPERCONTROL,${key},swapwindow,${direction}") directions)
        ++
        # Move monitor focus
        (lib.mapAttrsToList (key: direction: "SUPERALT,${key},focusmonitor,${direction}") directions)
        ++
        # Move workspace to other monitor
        (lib.mapAttrsToList (key: direction: "SUPERALTSHIFT,${key},movecurrentworkspacetomonitor,${direction}") directions);
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
