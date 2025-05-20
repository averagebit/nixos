{
  lib,
  config,
  ...
}: {
  sops.secrets = {
    forgejo-averagebit-password = {
      sopsFile = ../../secrets.yaml;
      owner = "forgejo";
    };
  };
  services = {
    forgejo = {
      enable = true;
      user = "forgejo";
      group = "forgejo";
      lfs.enable = true;
      settings = {
        server = {
          DOMAIN = "git.averagebit.com";
          ROOT_URL = "https://git.averagebit.com/";
          HTTP_PORT = 3500;
        };
        service.DISABLE_REGISTRATION = true;
        # actions = {
        #   ENABLED = true;
        #   DEFAULT_ACTIONS_URL = "github";
        # };
      };
    };
    nginx.virtualHosts = {
      "git.averagebit.com" = let
        port = config.services.forgejo.settings.server.HTTP_PORT;
      in {
        forceSSL = true;
        enableACME = true;
        acmeRoot = null;
        locations."/" = {
          proxyPass = "http://localhost:${toString port}";
          extraConfig = ''
            client_max_body_size 512M;
          '';
        };
      };
    };
  };
  systemd.tmpfiles.rules = let
    dir = config.services.forgejo.stateDir;
    user = config.services.forgejo.user;
    group = config.services.forgejo.group;
  in [
    "d ${dir}/custom 0750 ${user} ${group} -"
  ];
  systemd.services.forgejo.preStart = let
    cmd = "${lib.getExe config.services.forgejo.package} admin user";
    sec = config.sops.secrets.forgejo-averagebit-password;
    user = "averagebit";
  in ''
    ${cmd} create --admin --email "root@localhost" --username ${user} --password "$(tr -d '\n' < ${sec.path})" || true
    # ${cmd} change-password --username ${user} --password "$(tr -d '\n' < ${sec.path})" || true
  '';
  environment.persistence."/persist".directories = [
    "/var/lib/forgejo"
  ];
}
