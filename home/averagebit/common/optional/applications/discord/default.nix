{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [discord vesktop webcord-vencord];
  home.persistence = {
    "/persist/${config.home.homeDirectory}" = {
      directories = [
        ".config/discord"
        ".config/WebCord"
        ".config/vesktop/sessionData"
        ".config/vesktop/settings"
      ];
    };
  };
}
