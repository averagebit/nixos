{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [sc-controller];
  home.persistence = {
    "/persist/${config.home.homeDirectory}" = {
      allowOther = true;
      directories = [".config/scc"];
    };
  };
}
