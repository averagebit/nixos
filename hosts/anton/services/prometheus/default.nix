{
  lib,
  config,
  outputs,
  ...
}: let
  hosts = lib.attrNames outputs.nixosConfigurations;
in {
  services = {
    prometheus = {
      enable = true;
      globalConfig = {
        scrape_interval = "30s";
      };
      scrapeConfigs = [
        {
          job_name = "grafana";
          scheme = "https";
          static_configs = [{targets = ["dash.averagebit.com"];}];
        }
        {
          job_name = "prometheus";
          scheme = "https";
          static_configs = [{targets = ["metrics.averagebit.com"];}];
        }
        {
          job_name = "nginx";
          scheme = "https";
          static_configs = [{targets = ["anton.averagebit.com"];}];
        }
        {
          job_name = "hosts";
          scheme = "http";
          static_configs =
            map (hostname: {
              targets = ["${hostname}:${toString config.services.prometheus.exporters.node.port}"];
              labels.instance = hostname;
            })
            hosts;
        }
      ];
      extraFlags = let
        prometheus = config.services.prometheus.package;
      in [
        "--web.console.templates=${prometheus}/etc/prometheus/consoles"
        "--web.console.libraries=${prometheus}/etc/prometheus/console_libraries"
      ];
    };
    nginx.virtualHosts = {
      "metrics.averagebit.com" = {
        forceSSL = true;
        enableACME = true;
        acmeRoot = null;
        locations."/".proxyPass = "http://localhost:${toString config.services.prometheus.port}";
      };
    };
  };

  environment.persistence = {
    "/persist".directories = ["/var/lib/prometheus2"];
  };
}
