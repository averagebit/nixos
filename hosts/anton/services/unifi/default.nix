{pkgs, ...}: {
  services = {
    unifi = {
      enable = true;
      openFirewall = true;
      unifiPackage = pkgs.unifi;
      mongodbPackage = pkgs.mongodb;
    };
    nginx.virtualHosts = {
      "wifi.averagebit.com" = {
        enableACME = true;
        forceSSL = true;
        acmeRoot = null;
        locations."/" = {
          proxyPass = "https://localhost:8443";
          proxyWebsockets = true;
        };
      };
    };
  };
  environment.persistence."/persist".directories = [
    {
      directory = "/var/lib/unifi";
      user = "unifi";
      group = "unifi";
      mode = "0700";
    }
  ];
}
