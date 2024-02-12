{
  lib,
  config,
  ...
}: {
  services = {
    nginx = {
      enable = true;
      recommendedTlsSettings = true;
      recommendedProxySettings = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      clientMaxBodySize = "300m";

      virtualHosts."${config.networking.hostName}.averagebit.com" = {
        default = true;
        forceSSL = true;
        enableACME = true;
        acmeRoot = null;
        locations."/metrics" = {
          proxyPass = "http://localhost:${toString config.services.prometheus.exporters.nginxlog.port}";
        };
      };
    };

    prometheus.exporters.nginxlog = {
      enable = true;
      group = "nginx";
      settings.namespaces = [
        {
          name = "filelogger";
          source.files = ["/var/log/nginx/access.log"];
          format = "$remote_addr - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\"";
        }
      ];
    };

    uwsgi = {
      enable = true;
      user = "nginx";
      group = "nginx";
      plugins = ["cgi"];
      instance = {
        type = "emperor";
        vassals = lib.mkBefore {};
      };
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
