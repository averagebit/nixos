{
  config,
  lib,
  pkgs,
  ...
}: let
  swayEnabled = config.wayland.windowManager.sway.enable;
  hyprlandEnabled = config.wayland.windowManager.hyprland.enable;
in {
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      primary = {
        layer = "top";
        position = "bottom";
        height = 30;
        spacing = 10;

        modules-left =
          ["custom/menu"]
          ++ (lib.optionals swayEnabled [
            "sway/workspaces"
            "sway/scratchpad"
            "sway/mode"
          ])
          ++ (lib.optionals hyprlandEnabled [
            "hyprland/workspaces"
            "hyprland/submap"
          ]);

        modules-center =
          (lib.optionals swayEnabled ["sway/window"])
          ++ (lib.optionals hyprlandEnabled ["hyprland/window"]);

        modules-right =
          (lib.optionals swayEnabled ["sway/language"])
          ++ (lib.optionals hyprlandEnabled ["hyprland/language"])
          ++ [
            "tray"
            "network"
            "battery"
            "pulseaudio"
            "clock"
            "custom/notification"
          ];

        "custom/pad" = {
          format = "      ";
          tooltip = false;
        };
        "custom/menu" = {
          format = "";
          tooltip = false;
        };
        "custom/notification" = {
          format = "";
          tooltip = false;
        };
        "hyprland/workspaces" = {
          format = "{name}: {icon}";
          format-icons = {
            "1" = "󰞷";
            "2" = "󰈹";
            "3" = "󰙯";
            "4" = "";
            "5" = "󰒱";
            "6" = "󰞷";
            "7" = "";
            "8" = "";
            "9" = "";
            "10" = "󰠮";
            "11" = "󱕵";
            "12" = "󰎆";
            "13" = "󱧶";
            "14" = "󰓓";
            "15" = "";
            "16" = "󱁤";
            "17" = "󱂇";
            "18" = "󰌓";
            "19" = "󱎔";
            "20" = "";
            "urgent" = "";
          };
          sort-by = "number";
          on-scroll-up = "${pkgs.hyprland}/bin/hyprctl dispatch workspace e+1";
          on-scroll-down = "${pkgs.hyprland}/bin/hyprctl dispatch workspace e-1";
        };
        "hyprland/window" = {
          format = "{}";
          max-length = 50;
          separate-outputs = true;
          rewrite = {
            "" = "󰋜  ";
            "(.*) - Discord" = "󰙯  $1";
            "(.*) - Slack" = "  $1";
            "(.*) - Google Chrome" = "  $1";
            "(.*) - Obsidian.*" = "󰘝  $1";
            "(.*) - REAPER.*" = "󰎆  $1";
            "(.*) - Thunar" = "󱧶  $1";
            "(.*) - VLC media player" = "󰕼  $1";
            "(.*) — Mozilla Firefox" = "󰈹  $1";
            "Alacritty" = "󰞷  Terminal";
            "Foot" = "󰞷  Terminal";
            "Mozilla Firefox" = "󰈹  Firefox";
            "Steam" = "󰓓  Steam";
            "VLC media player" = "󰕼";
            "Vial" = "󰌓 Vial";
            "[0-9]:[0-9]:(.*) -.*" = "󰞷  $1";
          };
        };
        "hyprland/language" = {
          format = "{}";
          format-en = "";
          format-es = "ES";
        };
        "sway/workspaces" = {
          format = "{name}: {icon}";
          format-icons = {
            "1" = "󰞷";
            "2" = "";
            "3" = "󰭹";
            "4" = "";
            "5" = "󰎆";
            "6" = "󰞷";
            "7" = "";
            "8" = "󰒱";
            "9" = "";
            "10" = "󰠮";
            "11" = "󱕵";
            "12" = "󰎆";
            "13" = "󱧶";
            "14" = "󰓓";
            "15" = "";
            "16" = "󱁤";
            "17" = "󱂇";
            "18" = "󰌓";
            "19" = "󱎔";
            "20" = "";
            "urgent" = "";
          };
          all-outputs = true;
          sort-by = "number";
        };
        "sway/scratchpad" = {
          format = "{icon}{count}";
          show-empty = false;
          format-icons = ["" "󰖲"];
          tooltip = true;
          tooltip-format = "{app}: {title}";
        };
        "sway/mode" = {format = "󰩨 {}";};
        "sway/window" = {
          format = "{}";
          max-length = 50;
          rewrite = {
            "" = "󰋜  ";
            "(.*) - Discord" = "󰙯  $1";
            "(.*) - Slack" = "  $1";
            "(.*) - Google Chrome" = "  $1";
            "(.*) - Obsidian.*" = "󰘝  $1";
            "(.*) - REAPER.*" = "󰎆  $1";
            "(.*) - Thunar" = "󱧶  $1";
            "(.*) - VLC media player" = "󰕼  $1";
            "(.*) — Mozilla Firefox" = "󰈹  $1";
            "Alacritty" = "󰞷  Terminal";
            "Foot" = "󰞷  Terminal";
            "Mozilla Firefox" = "󰈹  Firefox";
            "Steam" = "󰓓  Steam";
            "VLC media player" = "󰕼";
            "Vial" = "󰌓 Vial";
            "[0-9]:[0-9]:(.*) -.*" = "󰞷  $1";
          };
        };
        clock = {
          format = "{:%a %I:%M %p}";
          format-alt = "󱛡 {:%A, %B %d, %Y (%I:%M %p %Z)}";
        };
        cpu = {
          format = "{usage}% ";
          interval = 1;
        };
        disk = {
          format = "{percentage_used}% ";
          path = "/";
          interval = 30;
        };
        memory = {
          format = "{}% ";
          interval = 1;
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = ["" ""];
          on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set -5%";
          on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set +5%";
        };
        battery = {
          interval = 60;
          full-at = 95;
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon}   {capacity}%";
          format-charging = " {capacity}%";
          format-icons = ["" "" "" "" ""];
          max-length = 25;
        };
        network = {
          format-wifi = " ";
          format-ethernet = "󰈀";
          format-linked = "󱘖 {ifname} (No IP)";
          format-disconnected = "󱘖 Not connected";
          tooltip-format = "{essid} {ipaddr}/{cidr}";
        };
        pulseaudio = {
          format = "{format_source}  {icon}  {volume}%";
          format-bluetooth = "{format_source} {icon} {volume}%";
          format-bluetooth-muted = "{format_source} 󰖁 {volume}%";
          format-muted = "{format_source} 󰖁 {volume}%";
          format-source = "";
          format-source-muted = "";
          format-icons = {
            default = ["" "" ""];
            headphone = "󰋋";
          };
          tooltip-format = "{desc}, {volume}%";
          scroll-step = 5;
          on-click = "${pkgs.pamixer}/bin/pamixer -t";
          on-click-right = "${pkgs.pamixer}/bin/pamixer --default-source -t";
          on-click-middle = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
        tray = {
          icon-size = 14;
          spacing = 10;
        };
      };
    };

    style = with config.colorscheme; ''
      * {
          border-radius: 0;
          border: none;
          font-size: 14px;
          min-height: 0;
          font-family: sans-serif;
          transition: none;
          text-shadow: none;
          box-shadow: none;
          margin: 0;
          padding: 0;
      }

      window#waybar {
          color: #${colors.base05};
          background: #${colors.base00};
          border-top: 1px solid #${colors.base01};
          box-shadow: inset 0 1px 0 0 #${colors.base02};
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      #workspaces button {
          color: #${colors.base04};
          background: #${colors.base00};
          border-top: 1px solid #${colors.base01};
          box-shadow: inset 0 1px 0 0 #${colors.base02};
          padding: 0px 4px;
          min-width: 10px;
      }

      #workspaces button:hover {
          color: #${colors.base0D};
      }

      #workspaces button.focused {
          color: #${colors.base0D};
          background: #${colors.base00};
          box-shadow:
              inset 0 -2px 0 0 #${colors.base0D},
              inset 0 1px 0 0 #${colors.base02};
      }

      #workspaces button.active {
          color: #${colors.base0D};
          background: #${colors.base00};
          box-shadow:
              inset 0 -2px 0 0 #${colors.base0D},
              inset 0 1px 0 0 #${colors.base02};
      }

      #workspaces button.urgent {
          color: #${colors.base08};
          background: #${colors.base00};
      }

      #battery.warning {
          color: #${colors.base0A};
          background: #${colors.base00};
      }

      #battery.critical {
          color: #${colors.base08};
          background: #${colors.base00};
      }

      #battery.charging {
          background: #${colors.base00};
      }

      #custom-menu {
          padding: 0 5px 0 15px;
      }

      #custom-notification {
          padding: 0 15px 0 5px;
      }

      #mode {
          color: #${colors.base00};
          background: #${colors.base0D};
          padding: 0 4px;
      }
    '';
  };
}
