{
  lib,
  config,
  ...
}: {
  services = {
    jellyseerr = {
      enable = true;
      configDir = "/var/lib/jellyseerr";
    };
    nginx.virtualHosts = {
      "requests.averagebit.com" = {
        forceSSL = true;
        enableACME = true;
        acmeRoot = null;
        locations."/" = let
          port = config.services.jellyseerr.port;
        in {
          proxyPass = "http://localhost:${toString port}";
          proxyWebsockets = true;
        };
      };
    };
  };
  environment.persistence."/persist".directories = [
    {
      directory = "/var/lib/jellyseerr";
      user = "jellyseerr";
      group = "jellyseerr";
      mode = "0700";
    }
  ];
  systemd.services.jellyseerr.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = lib.mkForce "jellyseerr";
    Group = lib.mkForce "jellyseerr";
  };
  users = {
    users.jellyseerr = {
      home = "/var/lib/jellyseerr";
      group = "jellyseerr";
      isSystemUser = true;
    };
    groups.jellyseerr = {};
  };
}
