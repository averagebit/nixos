{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common/global
    ../common/optional/tools/bash
    ../common/optional/tools/btop
    ../common/optional/tools/direnv
    ../common/optional/tools/gh
    ../common/optional/tools/git
    ../common/optional/tools/gpg
    ../common/optional/tools/lazygit
    ../common/optional/tools/openssh
    ../common/optional/tools/starship
    ../common/optional/tools/tmux
  ];

  home.packages = with pkgs; [
    cheat # cheat.sh browser
    clone # git clone wrapper
    ix # ix.io uploader
    myip # ip fetcher
    nh # Home manager and Nix wrapper
    nixd # Nix LSP
    alejandra # Nix Formatter
    pfetch # System information
    urlencode # URI encoder
    yank # copy utility
    yt-dlp # YouTube downloader
  ];

  home.stateVersion = lib.mkDefault "23.11";
}
