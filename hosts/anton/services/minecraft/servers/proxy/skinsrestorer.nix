{pkgs, ...}: {
  services.minecraft-servers.servers.proxy = rec {
    symlinks."plugins/SkinsRestorer.jar" = pkgs.fetchurl rec {
      pname = "SkinsRestorer";
      version = "15.0.7";
      url = "https://github.com/${pname}/${pname}X/releases/download/${version}/${pname}.jar";
      hash = "sha256-APhkCE+CeghzjLjV1CLqkcfJtsw8IHGMJKKfsGbflYI=";
    };
  };
}
