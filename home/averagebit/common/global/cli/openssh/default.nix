{
  config,
  outputs,
  ...
}: let
  hostnames = builtins.attrNames outputs.nixosConfigurations;
in {
  programs.ssh = {
    enable = true;
    userKnownHostsFile = "${config.home.homeDirectory}/.ssh/known_hosts.d/hosts";
    matchBlocks = {
      net = {
        host = builtins.concatStringsSep " " hostnames;
        forwardAgent = true;
        remoteForwards = [
          {
            bind.address = ''/%d/.gnupg-sockets/S.gpg-agent'';
            host.address = ''/%d/.gnupg-sockets/S.gpg-agent.extra'';
          }
          {
            bind.address = ''/%d/.waypipe/server.sock'';
            host.address = ''/%d/.waypipe/client.sock'';
          }
        ];
        forwardX11 = true;
        forwardX11Trusted = true;
        setEnv.WAYLAND_DISPLAY = "wayland-waypipe";
        extraOptions.StreamLocalBindUnlink = "yes";
      };
    };
  };

  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [".ssh/known_hosts.d"];
  };
}
