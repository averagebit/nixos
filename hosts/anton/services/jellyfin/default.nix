{
  lib,
  config,
  pkgs,
  ...
}: {
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      intel-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
      vpl-gpu-rt
    ];
  };
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};
  environment.systemPackages = with pkgs; [
    mkvtoolnix
    python313Packages.babelfish
    python313Packages.chardet
    python313Packages.dogpile-cache
    python313Packages.enzyme
    python313Packages.ffmpeg-python
    python313Packages.guessit
    python313Packages.pymediainfo
    python313Packages.pysubs2
    python313Packages.requests
    python313Packages.srt
    python313Packages.stevedore
    python313Packages.subliminal
    python313Packages.types-beautifulsoup4
  ];
  services = {
    jellyfin = {
      enable = true;
      cacheDir = "/var/lib/jellyfin/cache";
    };
    nginx.virtualHosts = {
      "tv.averagebit.com" = {
        forceSSL = true;
        enableACME = true;
        acmeRoot = null;
        locations."/" = {
          proxyPass = "http://localhost:8096";
          proxyWebsockets = true;
        };
      };
    };
  };

  systemd = {
    tmpfiles.settings.jellyfinDirs = {
      "${config.services.jellyfin.dataDir}".d.mode = lib.mkForce "750";
    };
    services.jellyfin.serviceConfig.UMask = lib.mkForce "0027";
  };
  environment.persistence."/persist".directories = [
    {
      directory = "/var/lib/jellyfin";
      user = config.services.jellyfin.user;
      group = config.services.jellyfin.group;
      mode = "0700";
    }
  ];
}
