{
  config,
  pkgs,
  ...
}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      # General
      main = {
        dpi-aware = true;
        layer = "overlay";
        fuzzy = false;
        tabs = 4;
        show-actions = false;
        terminal = "${pkgs.foot}/bin/foot";
        fields = "name,generic,comment,categories,filename,keywords";
        # launch-prefix = <not set>;
        # password-character = "*";
        # prompt = "❯";
        # output = <not set>;

        # Icons
        icons-enabled = true;
        # icon-theme = Arc;
        image-size-ratio = 1;

        # Font
        font = "sans-serif:weight=regular:size=14";
        line-height = 20;
        letter-spacing = 0;

        # Style
        width = 30;
        horizontal-pad = 10;
        vertical-pad = 10;
        inner-pad = 10;
        lines = 10;
      };

      colors = with config.colorscheme; {
        background = "${colors.base01}fa";
        selection = "${colors.base0D}fa";
        border = "${colors.base00}fa";
        text = "${colors.base05}fa";
        match = "${colors.base0D}fa";
        selection-text = "${colors.base01}fa";
        selection-match = "${colors.base05}fa";
      };

      border = {
        width = 1;
        radius = 0;
      };

      dmenu = {
        # mode=text  # text|index
        exit-immediately-if-empty = false;
      };
    };
  };
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".cache/fuzzel"];
  };
}
