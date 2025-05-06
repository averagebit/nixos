{pkgs, ...}: {
  services.minecraft-servers.servers.survival = {
    enable = true;
    enableReload = true;
    package = pkgs.inputs.nix-minecraft.paperServers.paper-1_21_4;
    jvmOpts = ((import ../../aikar-flags.nix) "2G") + "-Dpaper.disableChannelLimit=true";
    serverProperties = {
      server-port = 25565;
      online-mode = false;
      motd = "Nixcraft Survival";
      difficulty = 3;
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
      };
      "bukkit.yml".value = {
        settings.shutdown-message = "Server shutting down (probably restarting.)";
      };
    };
    symlinks = {
      "plugins/SkinsRestorer.jar" = pkgs.fetchurl rec {
        pname = "SkinsRestorer";
        version = "15.0.7";
        url = "https://github.com/${pname}/${pname}X/releases/download/${version}/${pname}.jar";
        hash = "sha256-APhkCE+CeghzjLjV1CLqkcfJtsw8IHGMJKKfsGbflYI=";
      };
      "plugins/Spark.jar" = let
        build = "483";
      in
        pkgs.fetchurl rec {
          pname = "spark";
          version = "1.10.134";
          url = "https://ci.lucko.me/job/${pname}/${build}/artifact/${pname}-bukkit/build/libs/${pname}-${version}-bukkit.jar";
          hash = "sha256-7X9XknJJcVwskiNUsYXgablUCIgnKnA4tNGA7f3o4rU=";
        };
    };
  };
}
