{
  lib,
  pkgs,
}:
(pkgs.writeShellApplication {
  name = "urlencode";
  text = builtins.readFile ./urlencode.sh;
})
// {
  meta = with lib; {
    homepage = "https://github.com/averagebit/nixos";
    description = "URL-encodes a given string or input lines";
    mainProgram = "urlencode";
    maintainers = with maintainers; [averagebit];
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [fromSource];
    license = licenses.apache;
  };
}
