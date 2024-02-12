{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    alejandra
    cargo
    fd
    gcc
    go
    jq
    nixpkgs-fmt
    ripgrep

    # # Language servers
    # ansible-language-server
    # yaml-language-server
    # tailwindcss-language-server
    # terraform-ls
    # taplo
    # sqls
    # rust-analyzer
    # marksman
    # lua-language-server
    # json-lsp
    # nodePackages.vls
    # # nodePackages.vscode-json-languageserver
    # nodePackages.svelte-language-server
    # nodePackages.typescript-language-server
    # nodePackages.vim-language-server
    #
    # # Formatters
    # nodePackages.prettier
    #
    # # Linters
    # tflint
  ];

  home.sessionVariables = {EDITOR = "vi";};

  home.file.".config/nvim" = {
    source = ./config;
    recursive = true;
  };

  home.persistence = {
    "/persist/home/${config.home.username}".directories = [
      ".local/share/nvim"
      ".local/state/nvim"
    ];
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
