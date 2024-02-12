{
  config,
  pkgs,
  ...
}: {
  imports = [./packages.nix];

  users.groups.guest.gid = 1010;
  users.users.guest = {
    uid = 1010;
    isNormalUser = true;
    shell = pkgs.bash;
    group = "guest";
    extraGroups = ["users" "audio" "video"];
  };

  environment.persistence = {
    "/persist".directories = ["/home/guest"];
  };
}
