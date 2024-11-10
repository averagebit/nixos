{inputs, ...}: {
  imports = [inputs.musnix.nixosModules.musnix];

  musnix = {
    enable = true;
    das_watchdog.enable = true;
  };
}
