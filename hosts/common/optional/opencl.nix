{pkgs, ...}: {
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };
}
