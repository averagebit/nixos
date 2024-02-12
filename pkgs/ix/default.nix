{
  lib,
  pkgs,
}:
(pkgs.writeShellApplication {
  name = "ix";
  runtimeInputs = with pkgs; [yank];
  text = builtins.readFile ./ix.sh;
})
// {
  meta = with lib; {
    homepage = "https://github.com/averagebit/nixos";
    description = "ix.io wrapper to read or upload snippets of text";
    mainProgram = "cheat";
    maintainers = with maintainers; [averagebit];
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [fromSource];
    license = licenses.apache;
  };
}
