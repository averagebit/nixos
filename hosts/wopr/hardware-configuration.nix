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
      kernelModules = ["kvm-amd" "v4l2loopback"];
    };
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
      timeout = 5;
    };
    extraModulePackages = with config.boot.kernelPackages; [v4l2loopback.out];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    '';
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
