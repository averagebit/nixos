{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ps3iso-utils
    rpcs3
  ];
  home.persistence = {
    "/persist/${config.home.homeDirectory}" = {
      allowOther = true;
      directories = [
        ".cache/rpcs3"
        ".config/rpcs3"
      ];
    };
  };
}
