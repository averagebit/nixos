{config, ...}: {
  services = {
    home-assistant = {
      enable = true;
      extraPackages = python3Packages:
        with python3Packages; [
          gtts
          isal
          psycopg2
          zlib-ng
        ];
      extraComponents = [
        "assist_pipeline"
        "bluetooth"
        "cast"
        "cloud"
        "conversation"
        "shelly"
        "default_config"
        "default_config"
        "deluge"
        "dhcp"
        "discord"
        "energy"
        "epic_games_store"
        "esphome"
        "file"
        "github"
        "go2rtc"
        "google_assistant"
        "google_assistant_sdk"
        "google_cloud"
        "google_drive"
        "google_generative_ai_conversation"
        "google_mail"
        "google_maps"
        "google_photos"
        "google_pubsub"
        "google_sheets"
        "google_tasks"
        "google_translate"
        "google_travel_time"
        "google_wifi"
        "history"
        "homeassistant_alerts"
        "html5"
        "isal"
        "jellyfin"
        "lastfm"
        "logbook"
        "media_source"
        "met"
        "minecraft_server"
        "mobile_app"
        "mqtt"
        "my"
        "ollama"
        "openweathermap"
        "prometheus"
        "radio_browser"
        "reddit"
        "shodan"
        "signal_messenger"
        "smartthings"
        "speedtestdotnet"
        "spotify"
        "ssdp"
        "steam_online"
        "stream"
        "sun"
        "tailscale"
        "usage_prediction"
        "usb"
        "webhook"
        "whois"
        "youtube"
        "zeroconf"
        "zha"
      ];
      configDir = "/var/lib/hass";
      config = {
        default_config = {};
        http = {
          server_host = "::1";
          trusted_proxies = ["::1"];
          use_x_forwarded_for = true;
        };
        "automation" = "!include automations.yaml";
        "script" = "!include scripts.yaml";
        "scene" = "!include scenes.yaml";
        # "template" = "!include template.yaml";
        backup = {};
        cloud = {};
        config = {};
        default_config = {};
        mobile_app = {};
        network = {};
        shopping_list = {};
        sun = {};
        system_health = {};
        system_log = {};
        zeroconf = {};
      };
    };

    nginx.virtualHosts = {
      "home.averagebit.com" = let
        port = config.services.home-assistant.config.http.server_port;
      in {
        forceSSL = true;
        enableACME = true;
        acmeRoot = null;
        extraConfig = ''
          proxy_buffering off;
        '';
        locations."/" = {
          proxyPass = "http://[::1]:${toString port}";
          proxyWebsockets = true;
        };
      };
    };
  };

  environment.persistence."/persist".directories = [
    "/var/lib/hass"
  ];
}
# {config, ...}: {
#   services = {
#     home-assistant = {
#       enable = true;
#       extraPackages = python3Packages:
#         with python3Packages; [
#           psycopg2
#           zlib-ng
#           isal
#         ];
#       extraComponents = [
#         "assist_pipeline"
#         "bluetooth"
#         "cast"
#         "cloud"
#         "conversation"
#         "default_config"
#         "deluge"
#         "dhcp"
#         "discord"
#         "energy"
#         "epic_games_store"
#         "esphome"
#         "file"
#         "github"
#         "go2rtc"
#         "google_assistant"
#         "google_assistant_sdk"
#         "google_cloud"
#         "google_drive"
#         "google_generative_ai_conversation"
#         "google_mail"
#         "google_maps"
#         "google_photos"
#         "google_pubsub"
#         "google_sheets"
#         "google_tasks"
#         "google_translate"
#         "google_translate"
#         "google_travel_time"
#         "google_wifi"
#         "history"
#         "homeassistant_alerts"
#         "html5"
#         "jellyfin"
#         "lastfm"
#         "logbook"
#         "media_source"
#         "met"
#         "minecraft_server"
#         "mobile_app"
#         "mqtt"
#         "my"
#         "ollama"
#         "openweathermap"
#         "prometheus"
#         "radio_browser"
#         "reddit"
#         "shodan"
#         "signal_messenger"
#         "smartthings"
#         "speedtestdotnet"
#         "spotify"
#         "ssdp"
#         "steam_online"
#         "stream"
#         "sun"
#         "tailscale"
#         "usage_prediction"
#         "usb"
#         "webhook"
#         "whois"
#         "youtube"
#         "zeroconf"
#       ];
#       configDir = "/var/lib/hass";
#       config = {
#         default_config = {};
#         http = {
#           server_host = "::1";
#           trusted_proxies = ["::1"];
#           use_x_forwarded_for = true;
#         };
#       };
#     };
#
#     nginx.virtualHosts = {
#       "home.averagebit.com" = let
#         port = config.services.home-assistant.config.http.server_port;
#       in {
#         forceSSL = true;
#         enableACME = true;
#         acmeRoot = null;
#         extraConfig = ''
#           proxy_buffering off;
#         '';
#         locations."/" = {
#           proxyPass = "http://[::1]:${toString port}";
#           proxyWebsockets = true;
#         };
#       };
#     };
#   };
#
#   environment.persistence."/persist".directories = [
#     "/var/lib/hass"
#   ];
# }

