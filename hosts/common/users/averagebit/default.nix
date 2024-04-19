{
  pkgs,
  config,
  ...
}: let
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.groups.averagebit.gid = 1000;
  users.users.averagebit = {
    uid = 1000;
    isNormalUser = true;
    shell = pkgs.bash;
    group = "averagebit";
    extraGroups =
      [
        "wheel"
        "users"
        "audio"
        "video"
      ]
      ++ ifTheyExist [
        "docker"
        "libvirtd"
        "minecraft"
        "mysql"
        "network"
        "podman"
        "wireshark"
      ];

    openssh.authorizedKeys.keys = [(builtins.readFile ../../../../home/averagebit/ssh.pub)];
    hashedPasswordFile = config.sops.secrets.averagebit-password.path;
    packages = with pkgs; [home-manager];
  };

  sops.secrets.averagebit-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  home-manager.users.averagebit = import ../../../../home/averagebit/${config.networking.hostName};

  security.pam.services.swaylock = {};
}
