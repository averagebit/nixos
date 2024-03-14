{
  inputs,
  outputs,
  lib,
  pkgs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./acme.nix
      ./fonts.nix
      ./locale.nix
      ./nix.nix
      ./openssh.nix
      ./optin-persistence.nix
      ./sops.nix
      ./sudo.nix
      ./tailscale.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.extraSpecialArgs = {inherit inputs outputs;};

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };

  environment = {
    defaultPackages = lib.mkForce [];
    systemPackages = with pkgs; [
      appimage-run # Runs AppImages on NixOS
      bashInteractive # Shell
      bind # DNS server and utilities
      btop # Resource management
      btrfs-progs # BTRFS management
      coreutils # GNU utilities
      dmidecode # Hardware informaton
      efibootmgr # EFI boot entry manager
      exiftool # Image information
      ffmpeg-full # Audio and video processing
      file # File type information
      git # Version control
      glxinfo # Test utilities for OpenGL
      hdparm # Disk information
      imagemagick # Image processing
      inetutils # Network utilities
      inxi # System information
      iputils # Network utilities
      lazygit # TUI Git client
      lm_sensors # Hardware sensors
      lshw # Hardware management
      lsof # Tool to list open files
      nix-index # Nix file database
      nix-tree # Nix store explorer
      p7zip # 7-Zip archive management
      pciutils # PCI management
      ranger # File explorer
      rar # Rar archive management
      rsync # Sync tool
      smartmontools # Disk management
      strace # Syscall diagnostic and debug tool
      tmux # Terminal multiplexer
      tree # Depth indented dir listing
      unrar # Rar archive management
      unzip # Zip archive management
      usbutils # USB management
      vim # Text editor
      zip # Zip archive management
    ];
  };

  hardware.enableRedistributableFirmware = true;
}
