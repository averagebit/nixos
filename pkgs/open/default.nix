{
  lib,
  pkgs,
}:
(pkgs.writeShellApplication {
  name = "open";
  runtimeInputs = with pkgs; [git];
  text = builtins.readFile ./open.sh;
})
// {
  meta = with lib; {
    homepage = "https://github.com/averagebit/nixos";
    description = "Wrapper around xdg-open and similar";
    mainProgram = "open";
    maintainers = with maintainers; [averagebit];
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [fromSource];
    license = licenses.apache;
  };
}

