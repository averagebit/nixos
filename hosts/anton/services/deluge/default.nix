{config, ...}: {
  systemd.tmpfiles.rules = [
    "d ${config.services.deluge.dataDir}/.config/deluge 0755 ${config.users.users.deluge.name} ${config.users.users.deluge.group} -"
  ];

  services.deluge = {
    enable = true;
    declarative = true;
    authFile = config.sops.secrets.deluge-accounts.path;
    config = {
      copy_torrent_file = true;
      move_completed = true;
      torrentfiles_location = "/media/storage/torrents/files";
      download_location = "/media/storage/torrents/downloading";
      move_completed_path = "/media/storage/torrents/completed";
      dont_count_slow_torrents = true;
      max_active_seeding = -1;
      max_active_limit = -1;
      max_active_downloading = 8;
      max_connections_global = -1;
      allow_remote = true;
      daemon_port = 58846;
      random_port = false;
      listen_ports = [
        6880
        6880
      ];
      random_outgoing_ports = true;
    };
    # openFirewall = true;
  };

  sops.secrets.deluge-accounts = {
    sopsFile = ../../secrets.yaml;
    owner = config.users.users.deluge.name;
    group = config.users.users.deluge.group;
    mode = "0600";
  };

  networking.firewall = {
    allowedTCPPorts = [58846];
    allowedTCPPortRanges = [
      {
        from = 6880;
        to = 6890;
      }
    ];
  };

  environment.persistence."/persist".directories = [
    "/var/lib/deluge"
  ];
}
