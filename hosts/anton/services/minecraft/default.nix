{
  inputs,
  config,
  lib,
  ...
}: {
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
    ./servers/limbo
    ./servers/lobby
    ./servers/proxy
    ./servers/survival
    ./servers/modpack
  ];

  sops.secrets.minecraft-secrets = {
    owner = "minecraft";
    group = "minecraft";
    mode = "0440";
    # VELOCITY_FORWARDING_SECRET, DATABASE_PASSWORD
    sopsFile = ../../secrets.yaml;
  };

  services.minecraft-servers = {
    enable = true;
    eula = true;
    environmentFile = config.sops.secrets.minecraft-secrets.path;
  };

  networking.firewall.allowedTCPPorts = [25565];

  services.mysql = {
    ensureDatabases = ["minecraft"];
    ensureUsers = [
      {
        name = "minecraft";
        ensurePermissions = {"minecraft.*" = "ALL PRIVILEGES";};
      }
    ];
  };
  users.users.mysql.extraGroups = ["minecraft"];
  systemd.services.mysql.postStart = lib.mkAfter ''
    source ${config.sops.secrets.minecraft-secrets.path}
    ${config.services.mysql.package}/bin/mysql <<EOF
      ALTER USER 'minecraft'@'localhost'
        IDENTIFIED VIA unix_socket OR mysql_native_password
        USING PASSWORD('$DATABASE_PASSWORD');
    EOF
  '';
}
