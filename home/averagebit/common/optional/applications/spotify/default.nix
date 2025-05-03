{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [spotify];
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [".config/spotify"];
  };
}
