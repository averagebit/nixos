{
  lib,
  pkgs,
}:
(pkgs.writeShellApplication {
  name = "clone";
  runtimeInputs = with pkgs; [git];
  text = builtins.readFile ./clone.sh;
})
// {
  meta = with lib; {
    homepage = "https://github.com/averagebit/nixos";
    description = "Wrapper around git clone";
    mainProgram = "clone";
    maintainers = with maintainers; [averagebit];
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [fromSource];
    license = licenses.apache;
  };
}
