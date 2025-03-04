{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [ledger-live-desktop];
  home.persistence = {
    "/persist/${config.home.homeDirectory}" = {
      directories = [
        ".config/Ledger Live"
      ];
    };
  };
}
