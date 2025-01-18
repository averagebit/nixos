{
  lib,
  pkgs,
}:
(pkgs.writeShellApplication {
  name = "cam";
  runtimeInputs = with pkgs; [android-tools scrcpy];
  text = builtins.readFile ./cam.sh;
})
// {
  meta = with lib; {
    homepage = "https://github.com/averagebit/nixos";
    description = "ADB and scrcpy wrapper for using Android phones as a camera.";
    mainProgram = "cam";
    maintainers = with maintainers; [averagebit];
    platforms = platforms.unix;
    sourceProvenance = with sourceTypes; [fromSource];
    license = licenses.apache;
  };
}

