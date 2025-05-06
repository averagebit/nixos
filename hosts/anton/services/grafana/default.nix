{config, ...}: {
  sops.secrets = {
    grafana-averagebit-password = {
      sopsFile = ../../secrets.yaml;
      owner = "grafana";
    };
  };

  services = {
    grafana = {
      enable = true;
      settings = {
        server.http_port = 3000;
        users.default_theme = "system";
        dashboards.default_home_dashboard_path = "${./dashboards}/hosts.json";
        security = {
          admin_user = "averagebit";
          admin_password = "$__file{${config.sops.secrets.grafana-averagebit-password.path}}";
          cookie_secure = true;
        };
        "auth.anonymous" = {
          enabled = true;
        };
      };
      provision = {
        enable = true;
        dashboards.settings.providers = [
          {
            options.path = ./dashboards;
          }
        ];
        datasources.settings = {
          apiVersion = 1;
          datasources = [
            {
              name = "Prometheus";
              type = "prometheus";
              access = "proxy";
              url = "https://metrics.averagebit.com";
              isDefault = true;
            }
          ];
        };
      };
    };
    nginx.virtualHosts = {
      "dash.averagebit.com" = let
        port = config.services.grafana.settings.server.http_port;
      in {
        forceSSL = true;
        enableACME = true;
        acmeRoot = null;
        locations."/".proxyPass = "http://localhost:${toString port}";
      };
    };
  };
}
