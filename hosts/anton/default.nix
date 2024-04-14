{
  imports = [
    ./hardware-configuration.nix
    ./services

    ../common/global
    ../common/users/averagebit

    ../common/optional/docker.nix
    ../common/optional/greetd.nix
    ../common/optional/libvirtd.nix
    ../common/optional/opencl.nix
    ../common/optional/opengl.nix
    ../common/optional/podman.nix
  ];

  networking = {
    hostName = "anton";
    useDHCP = true;
  };

  system.stateVersion = "23.11";
}
