{config, ...}: {
  imports = [./extraconfig.nix];
  services = {
    authelia.instances.main = {
      enable = true;
      secrets = {
        jwtSecretFile = config.sops.secrets.authelia-jwt-secret.path;
        sessionSecretFile = config.sops.secrets.authelia-session-secret.path;
        oidcHmacSecretFile = config.sops.secrets.authelia-oidc-hmac-secret.path;
        oidcIssuerPrivateKeyFile = config.sops.secrets.authelia-oidc-issuer-key.path;
        storageEncryptionKeyFile = config.sops.secrets.authelia-storage-key.path;
      };
      settingsFiles = [
        config.sops.secrets.authelia-identity-providers.path
      ];
      settings = {
        authentication_backend = {
          file = {
            path = config.sops.secrets.authelia-users.path;
          };
        };
        theme = "dark";
        server = {
          address = "tcp://127.0.0.1:9091";
        };
        log = {
          level = "debug";
          format = "text";
        };
        access_control = {
          default_policy = "deny";
          rules = [
            {
              domain = ["auth.averagebit.com"];
              policy = "bypass";
            }
            {
              domain = ["*.averagebit.com"];
              policy = "one_factor";
            }
          ];
        };
        session = {
          cookies = [
            {
              name = "authelia_session";
              expiration = "12h";
              inactivity = "45m";
              domain = "averagebit.com";
              authelia_url = "https://auth.averagebit.com";
              default_redirection_url = "https://home.averagebit.com";
            }
          ];
          redis.host = "/run/redis-authelia-main/redis.sock";
        };
        regulation = {
          max_retries = 3;
          find_time = "5m";
          ban_time = "15m";
        };
        storage = {
          local = {
            path = "/var/lib/authelia-main/db.sqlite3";
          };
        };
        notifier = {
          disable_startup_check = false;
          filesystem = {
            filename = "/var/lib/authelia-main/notification.txt";
          };
        };
      };
    };

    redis.servers.authelia-main = {
      enable = true;
      user = "authelia-main";
      port = 0;
      unixSocket = "/run/redis-authelia-main/redis.sock";
      unixSocketPerm = 600;
    };

    nginx.virtualHosts."auth.averagebit.com" = {
      enableACME = true;
      forceSSL = true;
      acmeRoot = null;
      locations."/" = {
        proxyPass = "http://localhost:9091";
        proxyWebsockets = true;
      };
    };
  };

  sops.secrets = {
    authelia-jwt-secret = {
      sopsFile = ../../secrets.yaml;
      owner = "authelia-main";
      group = "authelia-main";
    };
    authelia-session-secret = {
      sopsFile = ../../secrets.yaml;
      owner = "authelia-main";
      group = "authelia-main";
    };
    authelia-oidc-hmac-secret = {
      sopsFile = ../../secrets.yaml;
      owner = "authelia-main";
      group = "authelia-main";
    };
    authelia-oidc-issuer-key = {
      sopsFile = ../../secrets.yaml;
      owner = "authelia-main";
      group = "authelia-main";
    };
    authelia-storage-key = {
      sopsFile = ../../secrets.yaml;
      owner = "authelia-main";
      group = "authelia-main";
    };
    authelia-users = {
      sopsFile = ../../secrets.yaml;
      owner = "authelia-main";
      group = "authelia-main";
    };
    authelia-identity-providers = {
      sopsFile = ../../secrets.yaml;
      owner = "authelia-main";
      group = "authelia-main";
    };
  };

  environment.persistence."/persist".directories = [
    {
      directory = "/var/lib/authelia-main";
      user = config.services.authelia.instances.main.user;
      group = config.services.authelia.instances.main.group;
      mode = "0700";
    }
  ];
}
