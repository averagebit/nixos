{config, ...}: {
  programs.lazygit = {
    enable = true;
    settings = {
      gui.theme = with config.colorscheme; {
        lightTheme = true;
        activeBorderColor = ["${colors.base0D}" "bold"];
        inactiveBorderColor = ["${colors.base02}"];
        optionsTextColor = ["${colors.base0D}"];
        selectedLineBgColor = ["${colors.base02}"];
        selectedRangeBgColor = ["${colors.base02}"];
        cherryPickedCommitBgColor = ["${colors.base03}"];
        cherryPickedCommitFgColor = ["${colors.base0D}"];
        unstagedChangesColor = ["${colors.base08}"];
        defaultFgColor = ["${colors.base05}"];
        searchingActiveBorderColor = ["${colors.base0A}"];
      };
    };
  };
}
