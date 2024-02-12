{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ollama
  ];

  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".ollama"];
  };
}
