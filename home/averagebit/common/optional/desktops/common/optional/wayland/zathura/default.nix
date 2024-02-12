{config, ...}: {
  programs.zathura = {
    enable = true;
    options = with config.colorscheme; {
      sandbox = "strict";
      selection-clipboard = "clipboard";
      recolor = true;
      font = "sans-serif 14";

      default-bg = "#${colors.base00}";
      default-fg = "#${colors.base05}";

      recolor-lightcolor = "#${colors.base00}";
      recolor-darkcolor = "#${colors.base05}";

      completion-bg = "#${colors.base02}";
      completion-fg = "#${colors.base05}";
      completion-highlight-bg = "#${colors.base02}";
      completion-highlight-fg = "#${colors.base05}";
      completion-group-bg = "#${colors.base02}";
      completion-group-fg = "#${colors.base05}";

      statusbar-bg = "#${colors.base01}";
      statusbar-fg = "#${colors.base05}";

      notification-bg = "#${colors.base02}";
      notification-fg = "#${colors.base05}";
      notification-error-bg = "#${colors.base02}";
      notification-error-fg = "#${colors.base08}";
      notification-warning-bg = "#${colors.base02}";
      notification-warning-fg = "#${colors.base0A}";

      inputbar-bg = "#${colors.base02}";
      inputbar-fg = "#${colors.base05}";

      index-bg = "#${colors.base00}";
      index-fg = "#${colors.base05}";
      index-active-bg = "#${colors.base02}";
      index-active-fg = "#${colors.base05}";

      render-loading-bg = "#${colors.base00}";
      render-loading-fg = "#${colors.base05}";

      highlight-color = "#${colors.base02}";
      highlight-fg = "#${colors.base0F}";
      highlight-active-color = "#${colors.base0F}";
    };
  };
}
