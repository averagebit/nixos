{
  lib,
  config,
  ...
}: {
  services = {
    prowlarr = {
      enable = true;
      dataDir = "/var/lib/prowlarr";
      settings = {
        server.urlBase = "/prowlarr";
        log.analyticsEnabled = false;
        app.theme = "dark";
      };
    };
    nginx.virtualHosts = {
      "arr.averagebit.com" = {
        enableACME = true;
        forceSSL = true;
        acmeRoot = null;
        locations."/prowlarr/" = let
          port = config.services.prowlarr.settings.server.port;
        in {
          proxyPass = "http://localhost:${toString port}/prowlarr/";
          proxyWebsockets = true;
        };
      };
    };
  };
  environment.persistence."/persist".directories = [
    {
      directory = config.services.prowlarr.dataDir;
      user = "prowlarr";
      group = "prowlarr";
      mode = "0700";
    }
  ];
  systemd.services.prowlarr.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = lib.mkForce "prowlarr";
    Group = lib.mkForce "prowlarr";
  };
  users = {
    users.prowlarr = {
      home = config.services.prowlarr.dataDir;
      group = "prowlarr";
      isSystemUser = true;
    };
    groups.prowlarr = {};
  };
}
