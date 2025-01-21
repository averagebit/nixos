{pkgs, ...}: {
  imports = [
    ./awscli
    ./bash
    ./btop
    ./direnv
    ./gh
    ./git
    ./gpg
    ./helix
    ./lazygit
    ./ollama
    ./openssh
    ./shodan
    ./starship
    ./tmux
    ./weechat
    ./wine
    ./yabridgectl
  ];

  home.packages = with pkgs; [
    cam # Android cam setup wrapper
    cheat # cheat.sh browser
    clone # git clone wrapper
    distrobox # Podman wrapper for running other distros
    duck # Search duckduckgo
    ix # ix.io uploader
    myip # ip fetcher
    nh # Home manager and Nix wrapper
    open # Wrapper around xdg-open
    pfetch # System information
    python3Packages.huggingface-hub # Huggingface CLI
    scratch # Terminal scratchpad
    scrcpy # Mirror Android device
    urlencode # URI encoder
    yank # copy utility
    yt-dlp # YouTube downloader
  ];
}
