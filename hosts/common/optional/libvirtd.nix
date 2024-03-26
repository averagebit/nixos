{pkgs, ...}: {
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  programs.virt-manager.enable = true;

  environment.persistence = {
    "/persist".directories = ["/var/lib/libvirt"];
  };
}
