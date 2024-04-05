{pkgs}: let
  mainPkg = pkgs.callPackage ./default.nix {};
in
  pkgs.mkShell {
    inputsFrom = [mainPkg];
    nativeBuildInputs = with pkgs; [
      go
      gotools
      golangci-lint
    ];
  }
