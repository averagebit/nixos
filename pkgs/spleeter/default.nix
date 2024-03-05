{
  lib,
  pkgs,
}:
(pkgs.writeShellApplication {
  name = "spleeter";
  text = builtins.readFile ./spleeter.sh;
})
// {
  meta = with lib; {
    homepage = "https://github.com/deezer/spleeter";
    description = "Spleeter is a source separation library.";
    mainProgram = "spleeter";
    maintainers = with maintainers; [averagebit];
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [fromSource];
    license = licenses.mit;
  };
}
