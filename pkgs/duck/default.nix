{
  lib,
  pkgs,
}:
(pkgs.writeShellApplication {
  name = "duck";
  text = builtins.readFile ./duck.sh;
})
// {
  meta = with lib; {
    homepage = "https://github.com/averagebit/nixos";
    description = "Search duckduckgo";
    mainProgram = "duck";
    maintainers = with maintainers; [averagebit];
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [fromSource];
    license = licenses.apache;
  };
}

