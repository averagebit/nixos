{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.shadps4];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".local/share/shadPS4"];
  };
}
