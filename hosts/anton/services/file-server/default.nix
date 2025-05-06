{
  services.nginx.virtualHosts = {
    "anton.averagebit.com" = {
      forceSSL = true;
      enableACME = true;
      acmeRoot = null;
      locations."/".root = "/srv/files";
    };
  };
}
