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
        auto-format = true;
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          language-servers = ["nixd" "nil"];
          formatter = {command = "alejandra";};
          auto-format = true;
        }
        {
          name = "go";
          formatter = {command = "gofumpt";};
          auto-format = true;
        }
        {
          name = "javascript";
          formatter = {command = "prettierd";};
          auto-format = true;
        }
        {
          name = "typescript";
          formatter = {command = "prettierd";};
          auto-format = true;
        }
        {
          name = "json";
          formatter = {command = "prettierd";};
          auto-format = true;
        }
        {
          name = "jsx";
          formatter = {command = "prettierd";};
          auto-format = true;
        }
        {
          name = "vue";
          formatter = {command = "prettierd";};
          auto-format = true;
        }
        {
          name = "css";
          formatter = {command = "prettierd";};
          auto-format = true;
        }
        {
          name = "scss";
          formatter = {command = "prettierd";};
          auto-format = true;
        }
        {
          name = "markdown";
          formatter = {command = "prettierd";};
          auto-format = true;
        }
        {
          name = "graphql";
          formatter = {command = "prettierd";};
          auto-format = true;
        }
        {
          name = "yaml";
          formatter = {command = "prettierd";};
          auto-format = true;
        }
        {
          name = "html";
          formatter = {command = "prettierd";};
          auto-format = true;
        }
      ];
    };
  };
  xdg.configFile."helix/config.toml".onChange = ''
    ${pkgs.procps}/bin/pkill -u $USER -USR1 hx || true
  '';
}
