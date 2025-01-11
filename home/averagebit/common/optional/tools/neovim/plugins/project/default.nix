{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    telescope-project-nvim
    {
      plugin = project-nvim;
      type = "lua";
      config =
        /*
        lua
        */
        ''
          require("project_nvim").setup({
              active = true,
              on_config_done = nil,
              manual_mode = false,
              ignore_lsp = {},
              exclude_dirs = {},
              show_hidden = false,
              silent_chdir = true,
              scope_chdir = "global",
              detection_methods = { "pattern" },
              patterns = {
                  ".git",
                  "_darcs",
                  ".hg",
                  ".bzr",
                  ".svn",
                  "Makefile",
                  "package.json",
                  "pom.xml",
              },
          })
          require("telescope").load_extension("projects")
        '';
    }
  ];
}

