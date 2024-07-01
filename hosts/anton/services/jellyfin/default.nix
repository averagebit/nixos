{
  config,
  pkgs,
  ...
}: {
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime
    ];
  };
  services = {
    jellyfin = {
      enable = true;
      user = "jellyfin";
      group = "jellyfin";
    };
    nginx.virtualHosts = {
      "tv.averagebit.com" = {
        forceSSL = true;
        enableACME = true;
        acmeRoot = null;
        locations."/".proxyPass = "http://localhost:8096";
      };
    };
  };
  networking.firewall.allowedTCPPorts = [8096];
  environment.persistence."/persist".directories = [
    "/var/lib/jellyfin"
    "/srv/files/media"
  ];
}
