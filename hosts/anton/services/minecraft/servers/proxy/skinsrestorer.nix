{pkgs, ...}: {
  services.minecraft-servers.servers.proxy = rec {
    symlinks."plugins/SkinsRestorer.jar" = pkgs.fetchurl rec {
      pname = "SkinsRestorer";
      version = "15.0.6";
      url = "https://github.com/${pname}/${pname}X/releases/download/${version}/${pname}.jar";
      hash = "sha256-ople2iw4/T32CiojbajFCYn9FLckSOWNR6X23zqapY0=";
    };
  };
}
