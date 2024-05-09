{
  config,
  pkgs,
  ...
}: let
  # ollama = pkgs.ollama.override {acceleration = "rocm";};
in {
  home.packages = with pkgs; [ollama rocmPackages.rocm-smi rocmPackages.rocminfo];

  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".ollama"];
  };
}
