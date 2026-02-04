{config, ...}: {
  services = {
    vaultwarden = {
      enable = true;
      environmentFile = config.sops.secrets.vaultwarden.path;
      config = {
        DOMAIN = "https://pass.averagebit.com";
        SIGNUPS_ALLOWED = false;

        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
        ROCKET_LOG = "critical";
      };
    };
    nginx.virtualHosts = {
      "pass.averagebit.com" = {
        enableACME = true;
        forceSSL = true;
        acmeRoot = null;
        locations."/" = let
          port = config.services.vaultwarden.config.ROCKET_PORT;
        in {
          proxyPass = "http://localhost:${toString port}";
          proxyWebsockets = true;
        };
      };
    };
  };
  sops.secrets = {
    vaultwarden = {
      sopsFile = ../../secrets.yaml;
      owner = config.users.users.vaultwarden.name;
    };
  };
  environment.persistence."/persist".directories = [
    {
      directory = "/var/lib/bitwarden_rs";
      user = "vaultwarden";
      group = "vaultwarden";
      mode = "0700";
    }
  ];
}
