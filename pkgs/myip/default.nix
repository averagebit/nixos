{
  lib,
  pkgs,
}:
(pkgs.writeShellApplication {
  name = "myip";
  runtimeInputs = with pkgs; [dig];
  text = "dig +short myip.opendns.com @resolver1.opendns.com";
})
// {
  meta = with lib; {
    homepage = "https://github.com/averagebit/nixos";
    description = "Prints your public IP";
    mainProgram = "myip";
    maintainers = with maintainers; [averagebit];
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [fromSource];
    license = licenses.apache;
  };
}
