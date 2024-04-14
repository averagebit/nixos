{
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  environment.persistence = {
    "/persist".directories = ["/var/lib/containers"];
  };
}
