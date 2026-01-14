{config, ...}: {
  services = {
    sonarr = {
      enable = true;
      dataDir = "/var/lib/sonarr";
      settings = {
        server.urlBase = "/sonarr";
        log.analyticsEnabled = false;
      };
    };
    nginx.virtualHosts = {
      "arr.averagebit.com" = {
        forceSSL = true;
        enableACME = true;
        acmeRoot = null;
        locations."/sonarr/" = let
          port = config.services.sonarr.settings.server.port;
        in {
          proxyPass = "http://localhost:${toString port}/sonarr/";
          proxyWebsockets = true;
        };
      };
    };
  };
  users.users.sonarr.extraGroups = [
    config.users.users.deluge.group
    config.services.sabnzbd.group
  ];
  environment.persistence."/persist".directories = [
    {
      directory = config.services.sonarr.dataDir;
      user = config.services.sonarr.user;
      group = config.services.sonarr.group;
      mode = "0700";
    }
  ];
  systemd.tmpfiles.settings.srv-media-series."/media/storage/media/series".d = {
    user = config.services.sonarr.user;
    group = config.services.sonarr.group;
    mode = "0755";
  };
  systemd.tmpfiles.settings.srv-media-anime."/media/storage/media/anime".d = {
    user = config.services.sonarr.user;
    group = config.services.sonarr.group;
    mode = "0755";
  };
}
