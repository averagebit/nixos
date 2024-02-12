{config, ...}: {
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      pager = "less";
    };
  };
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/gh"];
  };
}
