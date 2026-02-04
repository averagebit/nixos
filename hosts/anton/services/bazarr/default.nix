{config, ...}: {
  services = {
    bazarr = {
      enable = true;
      dataDir = "/var/lib/bazarr";
    };
    nginx.virtualHosts = {
      "bazarr.averagebit.com" = {
        enableACME = true;
        forceSSL = true;
        acmeRoot = null;
        locations."/" = let
          port = config.services.bazarr.listenPort;
        in {
          proxyPass = "http://localhost:${toString port}";
          proxyWebsockets = true;
        };
      };
    };
  };
  users.users.bazarr.extraGroups = [
    config.services.sonarr.group
    config.services.radarr.group
  ];
  environment.persistence."/persist".directories = [
    {
      directory = config.services.bazarr.dataDir;
      user = config.services.bazarr.user;
      group = config.services.bazarr.group;
      mode = "0700";
    }
  ];
}
