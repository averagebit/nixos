{config, ...}: {
  services = {
    prometheus = {
      enable = true;
      globalConfig = {
        scrape_interval = "30s";
      };
      scrapeConfigs = [
        {
          job_name = "nginx";
          scheme = "https";
          static_configs = [
            {
              targets = ["anton.averagebit.com"];
            }
          ];
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
}
