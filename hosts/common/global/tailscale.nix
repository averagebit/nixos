{
  lib,
  config,
  ...
}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = lib.mkDefault "client";
    extraDaemonFlags = ["--no-logs-no-support"];
  };

  networking.firewall = {
    allowedUDPPorts = [config.services.tailscale.port];
    trustedInterfaces = ["tailscale0"];
  };

  environment.persistence = {
    "/persist".directories = ["/var/lib/tailscale"];
  };
}
