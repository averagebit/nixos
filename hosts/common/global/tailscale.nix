{lib, ...}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = lib.mkDefault "client";
  };

  networking.firewall.allowedUDPPorts = [41641];

  environment.persistence = {
    "/persist".directories = ["/var/lib/tailscale"];
  };
}
