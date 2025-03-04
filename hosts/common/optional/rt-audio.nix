{
  powerManagement.cpuFreqGovernor = "performance";

  boot.kernel.sysctl = {"vm.swappiness" = 10;};

  security.rtkit.enable = true;
  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "99";
    }
    {
      domain = "@audio";
      item = "nofile";
      type = "soft";
      value = "99999";
    }
    {
      domain = "@audio";
      item = "nofile";
      type = "hard";
      value = "99999";
    }
  ];

  services.udev = {
    extraRules = ''
      KERNEL=="rtc0", GROUP="audio"
      KERNEL=="hpet", GROUP="audio"
      DEVPATH=="/devices/virtual/misc/cpu_dma_latency", OWNER="root", GROUP="audio", MODE="0660"
    '';
  };

  environment.etc = {
    "pipewire.conf.d/rt.conf".text = ''
      {
        "context.properties": {
          "link.max-buffers": 16,
            "log.level": 2,
            "default.clock.rate": 48000,
            "default.clock.quantum": 128,
            "default.clock.min-quantum": 128,
            "default.clock.max-quantum": 128,
            "core.daemon": true,
            "core.name": "pipewire-0"
        },
        "context.modules": [
          {
            "name": "libpipewire-module-rtkit",
            "args": {
              "nice.level": -15,
              "rt.prio": 88,
              "rt.time.soft": 200000,
              "rt.time.hard": 200000
            },
            "flags": [ "ifexists", "nofail" ]
          },
          { "name": "libpipewire-module-protocol-native" },
          { "name": "libpipewire-module-profiler" },
          { "name": "libpipewire-module-metadata" },
          { "name": "libpipewire-module-spa-device-factory" },
          { "name": "libpipewire-module-spa-node-factory" },
          { "name": "libpipewire-module-client-node" },
          { "name": "libpipewire-module-client-device" },
          { "name": "libpipewire-module-portal", "flags": [ "ifexists", "nofail" ] },
          { "name": "libpipewire-module-access", "args": {} },
          { "name": "libpipewire-module-adapter" },
          { "name": "libpipewire-module-link-factory" },
          { "name": "libpipewire-module-session-manager" }
        ]
      }
    '';
  };
}
