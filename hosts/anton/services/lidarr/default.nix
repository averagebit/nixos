{config, ...}: {
  services = {
    lidarr = {
      enable = true;
      dataDir = "/var/lib/lidarr";
      settings = {
        server.urlBase = "/lidarr";
        log.analyticsEnabled = false;
      };
    };
    nginx.virtualHosts = {
      "arr.averagebit.com" = {
        forceSSL = true;
        enableACME = true;
        acmeRoot = null;
        locations."/lidarr/" = let
          port = config.services.lidarr.settings.server.port;
        in {
          proxyPass = "http://localhost:${toString port}/lidarr/";
          proxyWebsockets = true;
        };
      };
    };
  };
  users.users.lidarr.extraGroups = [
    config.users.users.deluge.group
    config.services.sabnzbd.group
  ];
  environment.persistence."/persist".directories = [
    {
      directory = config.services.lidarr.dataDir;
      user = config.services.lidarr.user;
      group = config.services.lidarr.group;
      mode = "0700";
    }
  ];
  systemd.tmpfiles.settings.srv-media-music."/media/storage/media/music".d = {
    user = config.services.lidarr.user;
    group = config.services.lidarr.group;
    mode = "0755";
  };
}
