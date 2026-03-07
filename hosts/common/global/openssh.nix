{
  lib,
  config,
  outputs,
  ...
}: let
  hosts = lib.attrNames outputs.nixosConfigurations;
  hasOptinPersistence = config.environment.persistence ? "/persist";
in {
  services.openssh = {
    enable = true;
    allowSFTP = true;
    settings = {
      AuthenticationMethods = "publickey";
      GatewayPorts = "clientspecified";
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      StreamLocalBindUnlink = "yes";
    };
    hostKeys = [
      {
        path = "${lib.optionalString hasOptinPersistence "/persist"}/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  programs.ssh = {
    knownHosts = lib.genAttrs hosts (hostname: {
      publicKeyFile = ../../${hostname}/ssh_host_ed25519_key.pub;
      extraHostNames =
        ["${hostname}"]
        ++ (lib.optional (hostname == config.networking.hostName) "localhost");
    });
  };
}
