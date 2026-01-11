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
    "/persist/".directories = [
      ".cache/rpcs3"
      ".config/rpcs3"
    ];
  };
}
