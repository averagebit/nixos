{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [python3Packages.shodan];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/shodan"];
  };
}
