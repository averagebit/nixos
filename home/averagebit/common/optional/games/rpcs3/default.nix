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
    "/persist/home/${config.home.username}" = {
      allowOther = true;
      directories = [
        ".cache/rpcs3"
        ".config/rpcs3"
      ];
    };
  };
}
