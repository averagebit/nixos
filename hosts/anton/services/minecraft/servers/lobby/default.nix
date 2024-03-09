{pkgs, ...}: {
  services.minecraft-servers.servers.lobby = {
    enable = true;
    enableReload = true;
    package = pkgs.inputs.nix-minecraft.paperServers.paper-1_20_4;
    jvmOpts = ((import ../../aikar-flags.nix) "2G") + "-Dpaper.disableChannelLimit=true";
    serverProperties = {
      server-port = 25574;
      online-mode = false;
      allow-nether = false;
      gamemode = "adventure";
      force-gamemode = true;
      spawn-animals = false;
      spawn-monsters = false;
      spawn-npcs = false;
      motd = "Nixcraft Lobby";
    };
    files = {
      "ops.json".value = [
        {
          uuid = "d8a0439a-1d36-48b3-889e-5740f08217a5";
          name = "blurdesign";
          bypassesPlayerLimit = true;
          level = 4;
        }
      ];
      "config/paper-global.yml".value = {
        timings.enabled = false;
        proxies.velocity = {
          enabled = true;
          online-mode = false;
          secret = "@VELOCITY_FORWARDING_SECRET@";
        };
      };
      "bukkit.yml".value = {
        settings = {
          allow-end = false;
          shutdown-message = "Server shutting down (probably restarting)";
        };
      };
      "plugins/LuckPerms/config.yml".value = {
        server = "lobby";
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
      "plugins/ViaVersion/config.yml".value = {
        checkforupdates = false;
      };
    };
    symlinks = {
      "plugins/LuckPerms.jar" = let
        build = "1530";
      in
        pkgs.fetchurl rec {
          pname = "LuckPerms";
          version = "5.4.117";
          url = "https://download.luckperms.net/${build}/bukkit/loader/${pname}-Bukkit-${version}.jar";
          hash = "sha256-ObcVauNAlObo9+QuBn2s7SRufZpANKtsyg/B16YnXcA=";
        };
      "plugins/SkinsRestorer.jar" = pkgs.fetchurl rec {
        pname = "SkinsRestorer";
        version = "15.0.7";
        url = "https://github.com/${pname}/${pname}X/releases/download/${version}/${pname}.jar";
        hash = "sha256-APhkCE+CeghzjLjV1CLqkcfJtsw8IHGMJKKfsGbflYI=";
      };
      "plugins/SignedVelocity.jar" = pkgs.fetchurl rec {
        pname = "SignedVelocity";
        version = "1.2.3";
        url = "https://github.com/4drian3d/${pname}/releases/download/${version}/${pname}-Paper-${version}.jar";
        hash = "sha256-IGYpE9oaqtqckbAXsZEf1nNY1hAHieqHYpfg+e/t8Uk=";
      };
      "plugins/ViaVersion.jar" = pkgs.fetchurl rec {
        pname = "ViaVersion";
        version = "4.9.2";
        url = "https://github.com/ViaVersion/${pname}/releases/download/${version}/${pname}-${version}.jar";
        hash = "sha256-jVBjs4hEV464xM0Edp1nGCefyIePG5/H7aavP/+9/o0=";
      };
      "plugins/ViaBackwards.jar" = pkgs.fetchurl rec {
        pname = "ViaBackwards";
        version = "4.9.1";
        url = "https://github.com/ViaVersion/${pname}/releases/download/${version}/${pname}-${version}.jar";
        hash = "sha256-j/mjgQwOn6C8VKtVcc/9gFSWzWLevaUwZDOZl7vXqGs=";
      };
      "plugins/HidePLayerJoinQuit.jar" = pkgs.fetchurl rec {
        pname = "HidePLayerJoinQuit";
        version = "1.0";
        url = "https://github.com/OskarZyg/${pname}/releases/download/v${version}-full-version/${pname}-${version}-Final.jar";
        hash = "sha256-UjLlZb+lF0Mh3SaijNdwPM7ZdU37CHPBlERLR3LoxSU=";
      };
      "plugins/Spark.jar" = let
        build = "400";
      in
        pkgs.fetchurl rec {
          pname = "spark";
          version = "1.10.59";
          url = "https://ci.lucko.me/job/${pname}/${build}/artifact/${pname}-bukkit/build/libs/${pname}-${version}-bukkit.jar";
          hash = "sha256-PoG+wBYCYCttYyJ88lH6xprqeUFs3gk9KMB/HC42HIc=";
        };
    };
  };
}
