{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [awscli2];
  home.persistence = {
    "/persist/".directories = [".config/aws"];
  };
}
