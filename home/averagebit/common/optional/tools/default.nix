{pkgs, ...}: {
  imports = [
    ./bash
    ./btop
    ./direnv
    ./gh
    ./git
    ./gpg
    ./lazygit
    ./neovim
    ./ollama
    ./openssh
    ./starship
    ./tmux
    ./weechat
  ];

  home.packages = with pkgs; [
    cheat
    clone
    ix
    myip
    urlencode
    yank
    distrobox # Podman wrapper for running other distros
    pfetch # System information
    nh # Home manager and Nix wrapper
    nil # Nix LSP
    yt-dlp # YouTube downloader
  ];
}
