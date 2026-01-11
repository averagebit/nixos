{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [ledger-live-desktop];
  home.persistence = {
    "/persist/".directories = [".config/Ledger Live"];
  };
}
