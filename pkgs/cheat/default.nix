{
  lib,
  pkgs,
}:
(pkgs.writeShellApplication {
  name = "cheat";
  runtimeInputs = with pkgs; [urlencode];
  text = builtins.readFile ./cheat.sh;
})
// {
  meta = with lib; {
    homepage = "https://github.com/averagebit/nixos";
    description = "Cheat sheets in the terminal";
    mainProgram = "cheat";
    maintainers = with maintainers; [averagebit];
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [fromSource];
    license = licenses.apache;
  };
}
