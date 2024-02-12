{pkgs, ...}: {
  services.minecraft-servers.servers.proxy = {
    extraReload = ''
      echo 'huskchat reload' > /run/minecraft-server/proxy.stdin
    '';
    files = {
      "plugins/huskchat/config.yml".value = {
        config-version = 1;
        default_channel = "default";
        channel_log_format = "[CHAT] [%channel%] %sender%: ";
        channel_command_aliases = ["/channel" "/c"];
        language = "en-gb";

        channels = let
          disabled.permissions = {
            send = "disabled";
            receive = "disabled";
          };
        in {
          default = {
            format = "&7[%servername%] %fullname%&r: ";
            broadcast_scope = "GLOBAL";
            log_to_console = true;
            shortcut_commands = ["/global" "/g" "/default" "/d"];
          };
          internal = {
            format = "%fullname%&r&0: ";
            broadcast_scope = "PASSTHROUGH";
            shortcut_commands = ["/i" "/internal"];
          };
          global = disabled;
          local = disabled;
          helpop = disabled;
          localspy = disabled;
        };
        broadcast_command = {
          enabled = true;
          broadcast_aliases = ["/broadcast" "/alert"];
          format = "&4[SERVER]&e ";
          log_to_console = true;
          log_format = "[SERVER]: ";
        };
        message_command = {
          enabled = true;
          msg_aliases = ["/msg" "/m" "/tell" "/whisper" "/w" "/pm"];
          reply_aliases = ["/reply" "/r"];
          log_to_console = true;
          log_format = "[MSG] [%sender% -> %receiver%]: ";
          group_messages.enabled = false;
          format = {
            inbound = "&#00fb9a&%name% &8→ &#00fb9a&You&8: &f";
            outbound = "&#00fb9a&You &8→ &#00fb9a&%name%&8: &f";
          };
        };
        social_spy.enabled = false;
        local_spy.enabled = false;
        chat_filters = {
          advertising_filter.enabled = false;
          caps_filter.enabled = false;
          spam_filter.enabled = false;
          profanity_filter.enabled = false;
          repeat_filter.enabled = false;
          ascii_filter.enabled = false;
        };
        message_replacers.emoji_replacer.enabled = false;
        discord.enabled = false;
        join_and_quit_messages = {
          join = {
            enabled = true;
            format = "&f%name%&e joined the server";
          };
          quit = {
            enabled = true;
            format = "&f%name%&e left the server";
          };
          broadcast_scope = "GLOBAL";
        };
      };
    };
    symlinks = {
      "plugins/HuskChat.jar" = pkgs.fetchurl rec {
        pname = "HuskChat";
        version = "2.7.1";
        url = "https://github.com/WiIIiam278/${pname}/releases/download/${version}/${pname}-${version}.jar";
        hash = "sha256-Vg0xu2Z7WeeabK1r5qOw9STcK9kxA5ApshljyXDUy7M=";
      };
      "plugins/SignedVelocity.jar" = pkgs.fetchurl rec {
        pname = "SignedVelocity";
        version = "1.2.3";
        url = "https://github.com/4drian3d/${pname}/releases/download/${version}/${pname}-Proxy-${version}.jar";
        hash = "sha256-cfWP26MVPPHrGt1iuss82HBQnlHhSuDeNTYJCZkqVSg=";
      };
      "plugins/VPacketEvents.jar" = pkgs.fetchurl rec {
        pname = "VPacketEvents";
        version = "1.1.0";
        url = "https://github.com/4drian3d/${pname}/releases/download/${version}/${pname}-${version}.jar";
        hash = "sha256-qWHR8hn56vf8csUDhuzV8WPBhZtaJE+uLNqupcJvGEI=";
      };
    };
  };
}
