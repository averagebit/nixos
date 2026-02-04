{
  programs.claude-code = {
    enable = true;
  };
  home.persistence = {
    "/persist/".directories = [
      ".claude"
    ];
  };
}
