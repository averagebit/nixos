{config, ...}: {
  imports = [./packages.nix];

  users.mutableUsers = false;
  users.users.guest = {
    isNormalUser = true;
    extraGroups = [
      "video"
      "audio"
    ];
    hashedPasswordFile = config.sops.secrets.guest-password.path;
  };

  sops.secrets.guest-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  environment.persistence = {
    "/persist".directories = ["/home/guest"];
  };
}
