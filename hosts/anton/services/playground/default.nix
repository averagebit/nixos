{pkgs, ...}: let
  user = "playground";
  group = "playground";
  dataDir = "/var/lib/playground";
in {
  virtualisation.libvirtd.enable = true;

  systemd.services."playground" = {
    description = "Playground VM";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.qemu}/bin/qemu-system-x86_64 -name playground -machine q35,accel=kvm -cpu host,kvm=on,+vmx -smp 2 -m 4096 -drive file=${dataDir}/drive.qcow2,format=qcow2,if=virtio,cache=none,aio=threads -netdev user,id=net0,hostfwd=tcp::2222-:22 -device virtio-net-pci,netdev=net0 -nographic";
      User = "${user}";
      Group = "${group}";
      CapabilityBoundingSet = "";
      NoNewPrivileges = true;
      PrivateTmp = true;
      ProtectClock = true;
      ProtectControlGroups = true;
      ProtectHome = true;
      ProtectHostname = true;
      ProtectSystem = "strict";
      ReadWritePaths = ["/var/lib/playground"];
      Restart = "always";
      RestrictRealtime = true;
      WorkingDirectory = "${dataDir}";
    };
  };

  users.users."${user}" = {
    isSystemUser = true;
    group = "${group}";
    extraGroups = ["kvm"];
    home = "${dataDir}";
    createHome = true;
  };
  users.groups.playground = {};

  environment.persistence."/persist".directories = [
    "/var/lib/playground"
  ];
}
