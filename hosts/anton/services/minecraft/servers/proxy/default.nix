{
  pkgs,
  config,
  ...
}: let
  servers = config.services.minecraft-servers.servers;
  proxyFlags = memory: "-Xms${memory} -Xmx${memory} -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:+UnlockExperimentalVMOptions -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:MaxInlineLevel=15";
in {
  imports = [
    ./fallbackserver.nix
    ./huskchat.nix
    ./librelogin.nix
    ./luckperms.nix
    ./skinsrestorer.nix
    ./velocitab.nix
  ];
  services.minecraft-servers.servers.proxy = {
    enable = true;
    enableReload = true;
    stopCommand = "end";
    extraReload = ''
      echo 'velocity reload' > /run/minecraft-server/proxy.stdin
    '';
    extraPreStop = ''
    '';
    package = pkgs.inputs.nix-minecraft.velocity-server;
    jvmOpts = proxyFlags "512M";

    files = {
      "velocity.toml".value = {
        config-version = "2.5";
        bind = "0.0.0.0:25565";
        motd = "Nixcraft";
        player-info-forwarding-mode = "modern";
        forwarding-secret-file = "";
        forwarding-secret = "@VELOCITY_FORWARDING_SECRET@";
        online-mode = false;
        servers = {
          lobby = "localhost:${toString servers.lobby.serverProperties.server-port}";
          survival = "localhost:${toString servers.survival.serverProperties.server-port}";
          modpack = "localhost:${toString servers.modpack.serverProperties.server-port}";
          limbo = "localhost:${toString servers.limbo.files."settings.yml".value.bind.port}";
          try = ["lobby"];
        };
        forced-hosts = {
          "modpack.averagebit.com" = ["modpack" "lobby"];
          "survival.averagebit.com" = ["survival" "lobby"];
        };
      };
    };
  };
}
