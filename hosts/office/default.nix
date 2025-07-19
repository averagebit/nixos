{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/averagebit
    ../common/users/guest

    ../common/optional/dconf.nix
    ../common/optional/docker.nix
    ../common/optional/greetd.nix
    ../common/optional/opengl.nix
    ../common/optional/pipewire.nix
    ../common/optional/podman.nix
    ../common/optional/thunar.nix
    ../common/optional/vial.nix
    ../common/optional/yubikey.nix
  ];

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  services.greetd = {
    restart = false;
    settings = {
      initial_session = {
        command = "sway";
        user = "averagebit";
      };
    };
  };

  system.stateVersion = "24.11";
}
