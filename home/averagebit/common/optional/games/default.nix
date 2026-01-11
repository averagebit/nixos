{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./prism
    ./rpcs3
    ./sc-controller
    ./shadps4
    ./steam
  ];
  home.packages = with pkgs; [ckan];
  home.persistence = {
    "/persist/".directories = [".local/share/CKAN"];
  };
}
