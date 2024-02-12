{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    (pkgs.lutris.override {extraPkgs = p: [p.wine];})
  ];
  home.persistence = {
    "/persist/home/${config.home.username}" = {
      allowOther = true;
      directories = [
        ".config/lutris"
        ".local/share/lutris"
      ];
    };
  };
}
