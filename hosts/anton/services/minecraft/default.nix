{inputs, ...}: {
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
    ./servers/survival
  ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    managementSystem = {
      tmux.enable = false;
      systemd-socket.enable = true;
    };
  };
}
