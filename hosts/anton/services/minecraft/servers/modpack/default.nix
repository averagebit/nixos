{pkgs, ...}: {
  services.minecraft-servers.servers.modpack = {
    enable = true;
    enableReload = true;
    package = pkgs.inputs.nix-minecraft.fabricServers.fabric-1_20_4;
    jvmOpts = (import ../../aikar-flags.nix) "6G";
    whitelist = import ../../whitelist.nix;
    serverProperties = {
      server-port = 25572;
      online-mode = false;
      motd = "Nixcraft Modpack";
      enforce-whitelist = true;
    };
    files = {
      "config/FabricProxy-Lite.toml".value = {
        hackEarlySend = true;
        hackOnlineMode = false;
        secret = "@VELOCITY_FORWARDING_SECRET@";
      };
      "config/luckperms/luckperms.conf".format = pkgs.formats.json {};
      "config/luckperms/luckperms.conf".value = {
        server = "modpack";
        storage-method = "mysql";
        data = {
          address = "127.0.0.1";
          database = "minecraft";
          username = "minecraft";
          password = "@DATABASE_PASSWORD@";
          table-prefix = "luckperms_";
        };
        messaging-service = "sql";
      };
    };
    symlinks = {
      "mods/fabric-api.jar" = pkgs.fetchurl rec {
        pname = "fabric-api";
        version = "0.96.0+1.20.4";
        url = "https://github.com/FabricMC/fabric/releases/download/${version}/${pname}-${version}.jar";
        hash = "sha256-qTEzWUyvthWdONy8pXm4zlIGiiH88OklJ5rJwWL6b74=";
      };
      "mods/FabricProxy-Lite.jar" = pkgs.fetchurl rec {
        pname = "FabricProxy-Lite";
        version = "2.7.0";
        url = "https://github.com/OKTW-Network/${pname}/releases/download/v${version}/${pname}-${version}.jar";
        hash = "sha256-TIsf/rQzrG0HYWgGgImkwypaHzjrX0U0ui8uHGkqTU8=";
      };
      "mods/CrossStitch.jar" = pkgs.fetchurl rec {
        pname = "crossstitch";
        version = "0.1.6";
        url = "https://cdn.modrinth.com/data/YkOyn1Pn/versions/dJioNlO8/${pname}-${version}.jar";
        hash = "sha256-z1qsXFV5sc6xsr0loV8eLcySJvV2cBY60fhBsvkFuC4=";
      };
      "mods/LuckPerms.jar" = let
        build = "1530";
      in
        pkgs.fetchurl rec {
          pname = "LuckPerms";
          version = "5.4.117";
          url = "https://download.luckperms.net/${build}/fabric/${pname}-Fabric-${version}.jar";
          hash = "sha256-1yG5+calBVyzZ9rEoHOZZ+0pzhK57h5/SE4GMcf2qdc=";
        };
    };
  };
}
