{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./plugins
    ./options
  ];

  home.packages = with pkgs; [
    fd
    ripgrep
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
