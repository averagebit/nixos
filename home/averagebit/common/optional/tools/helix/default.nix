{pkgs, ...}: {

  home = {
    sessionVariables = {EDITOR = "hx";};
    shellAliases = {vi = "hx";};
  };
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
          language-servers = ["nixd" "nil"];
          formatter = {command = "alejandra";};
        }
        {
          name = "go";
          formatter = {command = "gofumpt";};
        }
      ];
    };
  };
  xdg.configFile."helix/config.toml".onChange = ''
    ${pkgs.procps}/bin/pkill -u $USER -USR1 hx || true
  '';
}
