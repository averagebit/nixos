{config, ...}: {
  services = {
    radarr = {
      enable = true;
      dataDir = "/var/lib/radarr";
      settings = {
        server.urlBase = "/radarr";
        log.analyticsEnabled = false;
        app.theme = "dark";
      };
    };
    nginx.virtualHosts = {
      "arr.averagebit.com" = {
        enableACME = true;
        forceSSL = true;
        acmeRoot = null;
        locations."/radarr/" = let
          port = config.services.radarr.settings.server.port;
        in {
          proxyPass = "http://localhost:${toString port}/radarr/";
          proxyWebsockets = true;
        };
      };
    };
  };
  users.users.radarr.extraGroups = [
    config.users.users.deluge.group
    config.services.sabnzbd.group
  ];
  environment.persistence."/persist".directories = [
    {
      directory = config.services.radarr.dataDir;
      user = config.services.radarr.user;
      group = config.services.radarr.group;
      mode = "0700";
    }
  ];
  systemd.tmpfiles.settings.srv-media-movies."/media/storage/media/movies".d = {
    user = config.services.radarr.user;
    group = config.services.radarr.group;
    mode = "0755";
  };
}
