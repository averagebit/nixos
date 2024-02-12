{
  pkgs,
  lib,
  ...
}: {
  services.minecraft-servers.servers.proxy = rec {
    extraPostStart = ''
      echo 'lpv import initial.json.gz' > /run/minecraft-server/proxy.stdin
    '';
    extraReload = extraPostStart;
    files = {
      "plugins/luckperms/config.yml".value = {
        server = "proxy";
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
      "plugins/LuckPerms.jar" = let
        build = "1530";
      in
        pkgs.fetchurl rec {
          pname = "LuckPerms";
          version = "5.4.117";
          url = "https://download.luckperms.net/${build}/velocity/${pname}-Velocity-${version}.jar";
          hash = "sha256-LyvkENq6n0CxGyZGswXeb9lhC+dd1KV7cmoE7DqhUsQ=";
        };
      "plugins/luckperms/initial.json.gz".format = pkgs.formats.gzipJson {};
      "plugins/luckperms/initial.json.gz".value = let
        mkPermissions = lib.mapAttrsToList (key: value: {inherit key value;});
      in {
        groups = {
          owner.nodes = mkPermissions {
            "group.admin" = true;
            "prefix.1000.&5" = true;
            "weight.1000" = true;

            "fallback.*" = true;
            "librelogin.*" = true;
            "luckperms.*" = true;
            "skinsrestorer.*" = true;
            "velocity.*" = true;
          };
          admin.nodes = mkPermissions {
            "group.default" = true;
            "prefix.900.&6" = true;
            "weight.900" = true;

            "huskchat.command.broadcast" = true;
          };
          default.nodes = mkPermissions {
            "huskchat.command.channel" = true;
            "huskchat.command.msg" = true;
            "huskchat.command.msg.reply" = true;
          };
        };
        users = {
          "d8a0439a-1d36-48b3-889e-5740f08217a5" = {
            username = "blurdesign";
            nodes = mkPermissions {
              "group.owner" = true;
            };
          };
          "b1264c6e-4e7a-3391-8f46-95abe3aa5061" = {
            username = "ner_viosa";
            nodes = mkPermissions {
              "group.admin" = true;
            };
          };
        };
      };
    };
  };
}
