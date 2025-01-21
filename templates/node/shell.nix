{pkgs}: let
  npxAlias = name: pkgs.writeShellScriptBin name "npx ${name} \"$@\"";
in
  pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      nodejs
      (npxAlias "tsc")
      (npxAlias "tsserver")
      docker-compose-language-service
      dockerfile-language-server-nodejs
      marksman
      taplo
      typescript-language-server
      vscode-langservers-extracted
      yaml-language-server
    ];
    shellHook = ''
      npm install
    '';
  }
