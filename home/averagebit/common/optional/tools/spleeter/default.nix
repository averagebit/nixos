{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [spleeter];

  home.sessionVariables = {SPLEETER_MODEL_DIR = "$HOME/.local/share/spleeter";};

  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".local/share/spleeter"];
  };
}
