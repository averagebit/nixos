{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [sc-controller];
  home.persistence = {
    "/persist/".directories = [".config/scc"];
  };
}
