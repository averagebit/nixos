{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel

    ../common/optional/ephemeral-btrfs.nix
  ];
  boot = {
    initrd = {
      availableKernelModules = [
        "ahci"
        "ehci_pci"
        "mpt3sas"
        "scsi_mod"
        "sd_mod"
        "sr_mod"
        "usb_storage"
        "usbhid"
      ];
      kernelModules = ["kvm-intel"];
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
    kernelPackages = pkgs.linuxPackages_latest;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/ESP";
    fsType = "vfat";
  };

  fileSystems."/media/storage" = {
    device = "/dev/disk/by-label/storage";
    fsType = "btrfs";
    options = ["subvol=@" "noatime" "compress=zstd"];
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 8196;
    }
  ];

  nixpkgs.hostPlatform.system = "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = true;
}
