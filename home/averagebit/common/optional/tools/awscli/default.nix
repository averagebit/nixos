{
  config,
  pkgs,
  ...
}: {
  # https://github.com/NixOS/nixpkgs/issues/298023
  # home.packages = with pkgs; [awscli2];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/aws"];
  };
}
