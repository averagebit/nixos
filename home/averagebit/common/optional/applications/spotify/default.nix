{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [spotify];
  home.persistence = {
    "/persist/".directories = [
      ".cache/spotify"
      ".config/spotify"
    ];
  };
}
