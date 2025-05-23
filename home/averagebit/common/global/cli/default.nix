{pkgs, ...}: {
  imports = [
    ./bash
    ./btop
    ./direnv
    ./fzf
    ./gh
    ./git
    ./gpg
    ./lazygit
    ./neovim
    ./openssh
    ./nitch
    ./starship
    ./tmux
  ];

  home.packages = with pkgs; [
    alejandra # Nix Formatter
    bash-language-server # Bash LSP
    cheat # cheat.sh browser
    clone # git clone wrapper
    distrobox # Podman wrapper for running other distros
    duck # Search duckduckgo
    myip # ip fetcher
    nh # Home manager and Nix wrapper
    nix-search-tv # Fuzzy search for NixOS packages
    nixd # Nix LSP
    prettierd # Common formatter
    urlencode # URI encoder
  ];
}
