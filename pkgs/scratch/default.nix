{
  lib,
  pkgs,
}:
(pkgs.writeShellApplication {
  name = "scratch";
  runtimeInputs = with pkgs; [neovim];
  text = builtins.readFile ./scratch.sh;
})
// {
  meta = with lib; {
    homepage = "https://github.com/averagebit/nixos";
    description = "Terminal scratchpad";
    mainProgram = "scratch";
    maintainers = with maintainers; [averagebit];
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [fromSource];
    license = licenses.apache;
  };
}

