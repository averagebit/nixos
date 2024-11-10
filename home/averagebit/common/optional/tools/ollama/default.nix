{
  config,
  pkgs,
  ...
}: let
in {
  home.packages = with pkgs; [ollama-rocm];

  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".ollama"];
  };
}
