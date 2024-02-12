{
  lib,
  config,
  ...
}: {
  sops.secrets.cloudflare-secrets = {
    sopsFile = ../secrets.yaml;
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "averagebit@pm.me";
      dnsProvider = "cloudflare";
      environmentFile = config.sops.secrets.cloudflare-secrets.path;
    };
  };

  environment.persistence = {
    "/persist".directories = ["/var/lib/acme"];
  };
}
