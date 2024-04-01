{
  pkgs,
  nixpkgs,
}: let
  npxAlias = name: pkgs.writeShellScriptBin name "npx ${name} \"$@\"";
  buildNodeJs = pkgs.callPackage "${nixpkgs}/pkgs/development/web/nodejs/nodejs.nix" {
    python = pkgs.python3;
  };
  nodejs = buildNodeJs {
    enableNpm = true;
    version = "21.6.2";
    sha256 = "sha256-GRKU1EXR5oADWazIF0UpseGOECFH3F9ZYDDT3OlpMeU=";
  };
in
  pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      nodejs
      (npxAlias "tsc")
      (npxAlias "tsserver")
    ];
    shellHook = ''
      npm install
    '';
  }
