{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [bottles];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".local/share/bottles"];
  };
}
