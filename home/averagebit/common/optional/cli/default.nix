{pkgs, ...}: {
  imports = [
    ./awscli
    ./bash
    ./btop
    ./direnv
    ./fzf
    ./gh
    ./git
    ./gpg
    ./jira
    ./lazygit
    ./neovim
    ./openssh
    ./starship
    ./tmux
  ];

  home.packages = with pkgs; [
    alejandra # Nix Formatter
    bash-language-server # Bash LSP
    cam # Android cam setup wrapper
    cheat # cheat.sh browser
    clone # git clone wrapper
    distrobox # Podman wrapper for running other distros
    duck # Search duckduckgo
    ix # ix.io uploader
    myip # ip fetcher
    nh # Home manager and Nix wrapper
    nixd # Nix LSP
    open # Wrapper around xdg-open
    pfetch # System information
    scratch # Terminal scratchpad
    scrcpy # Mirror Android device
    urlencode # URI encoder
    yank # Copy utility
    yt-dlp # YouTube downloader
  ];
}
