{
  lib,
  pkgs,
}:
(pkgs.writeShellApplication {
  name = "yank";
  text = builtins.readFile ./yank.sh;
})
// {
  meta = with lib; {
    homepage = "https://github.com/averagebit/nixos";
    description = "Wrapper around common clipboards taking a string or file as input";
    mainProgram = "yank";
    maintainers = with maintainers; [averagebit];
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [fromSource];
    license = licenses.apache;
  };
}
