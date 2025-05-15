{pkgs}: let
  mainPkg = pkgs.callPackage ./default.nix {};
in
  pkgs.mkShell {
    inputsFrom = [mainPkg];
    nativeBuildInputs = with pkgs; [
      delve
      errcheck
      go
      gofumpt
      golangci-lint-langserver
      gopls
      gotools
    ];
  }
