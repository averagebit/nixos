{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [webcord-vencord];
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/WebCord"];
  };
}
