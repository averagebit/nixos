{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [weechat];

  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/weechat"];
  };
}
