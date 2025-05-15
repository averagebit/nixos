{config, ...}: {
  services = {
    audiobookshelf = {
      enable = true;
      user = "audiobookshelf";
      group = "audiobookshelf";
      # openFirewall = true;
    };
    nginx.virtualHosts = {
      "books.averagebit.com" = let
        port = config.services.audiobookshelf.port;
      in {
        forceSSL = true;
        enableACME = true;
        acmeRoot = null;
        locations."/" = {
          proxyPass = "http://localhost:${toString port}";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_redirect http:// $scheme://;
          '';
        };
      };
    };
  };
  environment.persistence."/persist".directories = [
    "/var/lib/audiobookshelf"
  ];
}
