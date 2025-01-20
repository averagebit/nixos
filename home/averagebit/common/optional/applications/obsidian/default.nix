{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [obsidian];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/obsidian"];
  };
}

