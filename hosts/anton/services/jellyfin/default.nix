{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime
      vpl-gpu-rt
      intel-media-sdk
    ];
  };
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};
  services = {
    jellyfin = {
      enable = true;
      user = "jellyfin";
      group = "jellyfin";
      cacheDir = "/var/lib/jellyfin/cache";
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
