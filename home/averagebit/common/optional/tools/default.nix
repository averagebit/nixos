{pkgs, ...}: {
  imports = [
    ./awscli
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
    ./spleeter
    ./starship
    ./tmux
    ./weechat
  ];

  home.packages = with pkgs; [
    cheat # cheat.sh browser
    clone # git clone wrapper
    distrobox # Podman wrapper for running other distros
    ix # ix.io uploader
    myip # ip fetcher
    nh # Home manager and Nix wrapper
    nil # Nix LSP
    pfetch # System information
    python3Packages.huggingface-hub # Huggingface CLI
    sst # SST AWS serverless dev stuff
    urlencode # URI encoder
    yank # copy utility
    yt-dlp # YouTube downloader
  ];
}
