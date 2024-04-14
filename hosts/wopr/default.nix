{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/averagebit

    ../common/optional/dconf.nix
    ../common/optional/docker.nix
    ../common/optional/gamemode.nix
    ../common/optional/greetd.nix
    ../common/optional/libvirtd.nix
    ../common/optional/opencl.nix
    ../common/optional/opengl.nix
    ../common/optional/pipewire.nix
    ../common/optional/podman.nix
    ../common/optional/steam-hardware.nix
    ../common/optional/thunar.nix
    ../common/optional/vial.nix
    ../common/optional/wireshark.nix
    ../common/optional/yubikey.nix
  ];

  networking = {
    hostName = "wopr";
    useDHCP = true;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  services.greetd = {
    restart = false;
    settings = {
      initial_session = {
        command = "Hyprland";
        user = "averagebit";
      };
    };
  };

  system.stateVersion = "23.11";
}
