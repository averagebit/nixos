{config, ...}: {
  services = {
    actual = {
      enable = true;
      user = "actual";
      group = "actual";
      settings = {
        port = 7996;
        userCreationMode = "login";
        # enforceOpenId = true;
        # openId = {
        #   discoveryURL = "https://auth.averagebit.com/.well-known/openid-configuration";
        #   server_hostname = "https://budget.averagebit.com";
        #   client_id._secret = config.sops.secrets.authelia-actual-client-id.path;
        #   client_secret._secret = config.sops.secrets.authelia-actual-client-secret.path;
        #   authMethod = "openid";
        # };
      };
      openFirewall = true;
    };
    nginx.virtualHosts = {
      "budget.averagebit.com" = let
        port = config.services.actual.settings.port;
      in {
        forceSSL = true;
        enableACME = true;
        acmeRoot = null;
        locations."/" = {
          proxyPass = "http://localhost:${toString port}";
          proxyWebsockets = true;
        };
      };
    };
  };
  users = {
    users.actual = {
      home = config.services.actual.settings.dataDir;
      group = "actual";
      isSystemUser = true;
    };
    groups.actual = {};
  };
  # sops.secrets = {
  #   authelia-actual-client-id = {
  #     sopsFile = ../../secrets.yaml;
  #     owner = "actual";
  #     group = "actual";
  #   };
  #   authelia-actual-client-secret = {
  #     sopsFile = ../../secrets.yaml;
  #     owner = "actual";
  #     group = "actual";
  #   };
  # };
  systemd.tmpfiles.rules = [
    "d /var/lib/actual/user-files 0700 actual actual -"
    "d /var/lib/actual/server-files 0700 actual actual -"
  ];
  environment.persistence."/persist".directories = [
    {
      directory = config.services.actual.settings.dataDir;
      user = config.services.actual.user;
      group = config.services.actual.group;
      mode = "0700";
    }
  ];
}
