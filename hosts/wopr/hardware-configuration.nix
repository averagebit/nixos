{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd

    ../common/optional/encrypted-root.nix
    ../common/optional/ephemeral-btrfs.nix
  ];
  boot = {
    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = ["kvm-amd"];
    };
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
      timeout = 5;
    };
    kernelParams = ["console=tty1"];
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/ESP";
    fsType = "vfat";
  };

  fileSystems."/media/storage" = {
    device = "/dev/disk/by-label/HDD1";
    fsType = "btrfs";
    options = ["subvol=@" "compress=zstd"];
  };

  fileSystems."/media/dev" = {
    device = "dev:/averagebit";
    fsType = "nfs";
    options = ["x-systemd.automount" "x-systemd.idle-timeout=600" "noauto"];
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 8196;
    }
  ];

  networking = {
    hostName = "wopr";
    networkmanager.enable = true;
  };

  nixpkgs.hostPlatform.system = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;
}
