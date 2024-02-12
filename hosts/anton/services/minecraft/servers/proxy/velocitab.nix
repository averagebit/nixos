{pkgs, ...}: {
  services.minecraft-servers.servers.proxy = {
    extraReload = ''
      echo 'velocitab reload' > /run/minecraft-server/proxy.stdin
    '';
    symlinks = {
      "plugins/Velocitab.jar" = pkgs.fetchurl rec {
        pname = "Velocitab";
        version = "1.6.2";
        url = "https://github.com/WiIIiam278/${pname}/releases/download/${version}/${pname}-${version}.jar";
        hash = "sha256-BHJqF7781Lys/LAwlW89UKStPx3hlOy9vV9Tyo2teFs=";
      };
    };
    files = {
      "plugins/velocitab/config.yml".value = {
        fallback_enabled = true;
        fallback_group = "default";
        only_list_players_in_same_group = false;
        server_display_names = {};

        formatter = "MINEDOWN";
        enable_papi_hook = true;
        enable_mini_placeholders_hook = true;
        sort_players = true;
      };
      "plugins/velocitab/tab_groups.yml".value = {
        groups = [
          {
            name = "default";
            headers = ["&7Nixcraft"];
            footers = [];
            format = "&7[%server%] &r%prefix%%username%";
            nametag = {
              prefix = "&f%prefix%";
              suffix = "&f%suffix%";
            };
            servers = ["lobby" "survival" "modpack"];
            sorting_placeholders = ["%role_weight%" "%role_name%"];
            header_footer_update_rate = 1000;
            placeholder_update_rate = 1000;
          }
        ];
      };
    };
  };
}
