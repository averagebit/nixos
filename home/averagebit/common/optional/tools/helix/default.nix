{pkgs, ...}: {

  home.sessionVariables = {EDITOR = "hx";};
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        true-color = true;
        color-modes = true;
        line-number = "relative";
        bufferline = "multiple";
        indent-guides.render = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        auto-save.focus-lost = true;
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          formatter.command = "${pkgs.alejandra}/bin/alejandra";
          language-servers = ["nixd" "nil"];
        }
      ];
    };
  };
  xdg.configFile."helix/config.toml".onChange = ''
    ${pkgs.procps}/bin/pkill -u $USER -USR1 hx || true
  '';
}
