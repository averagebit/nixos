{pkgs}: let
  npxAlias = name: pkgs.writeShellScriptBin name "npx ${name} \"$@\"";
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
