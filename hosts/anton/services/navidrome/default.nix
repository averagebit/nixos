{config, ...}: {
  services = {
    navidrome = {
      enable = true;
      settings = {
        Address = "0.0.0.0";
        Port = 4533;
        MusicFolder = "/media/storage/media/music";
        CovertArtPriority = "*.jpg, *.JPG, *.png, *.PNG, embedded";
        AutoImportPlaylists = false;
        # EnableSharing = true;
        # "LastFM.Enabled" = true;
        # "LastFM.ApiKey" = config.sops.secrets.last-fm-key.path;
        # "LastFM.Secret" = config.sops.secrets.last-fm-secret.path;
      };
    };

    nginx.virtualHosts = {
      "music.averagebit.com" = let
        port = config.services.navidrome.settings.Port;
      in {
        forceSSL = true;
        enableACME = true;
        acmeRoot = null;
        locations."/".proxyPass = "http://localhost:${toString port}";
      };
    };
  };

  # sops.secrets = {
  #   last-fm-key = {
  #     sopsFile = ../secrets.yaml;
  #     owner = config.users.users.navidrome.name;
  #     group = config.users.users.navidrome.name;
  #   };
  #   last-fm-secret = {
  #     sopsFile = ../secrets.yaml;
  #     owner = config.users.users.navidrome.name;
  #     group = config.users.users.navidrome.name;
  #   };
  # };

  environment.persistence = {
    "/persist".directories = ["/var/lib/navidrome"];
  };
}
