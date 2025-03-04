{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [sc-controller];
  home.persistence = {
    "/persist/home/${config.home.username}" = {
      allowOther = true;
      directories = [".config/scc"];
    };
  };
}
