{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [krita];
  home.persistence = {
    "/persist/" = {
      directories = [".local/share/krita"];
      files = [
        ".config/kritadisplayrc"
        ".config/kritarc"
      ];
    };
  };
}
