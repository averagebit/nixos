{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [vesktop];
  home.persistence = {
    "/persist/".directories = [
      ".config/vesktop/sessionData"
      ".config/vesktop/settings"
    ];
  };
}
