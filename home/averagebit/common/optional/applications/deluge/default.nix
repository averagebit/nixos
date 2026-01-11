{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [deluge];
  home.persistence = {
    "/persist/".directories = [
      ".config/deluge"
    ];
  };
}
