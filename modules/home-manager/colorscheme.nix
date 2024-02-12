{lib, ...}: let
  inherit (lib) types mkOption listToAttrs;
in {
  options.colorscheme = {
    author = mkOption {
      type = types.string;
      default = "";
      description = "Colorscheme author";
    };
    scheme = mkOption {
      type = types.string;
      default = "";
      description = "Colorscheme name";
    };
    colors = let
      mkColorOption = name: {
        inherit name;
        value = mkOption {
          type = types.strMatching "[a-fA-F0-9]{6}";
          description = "${name} color";
          default = "ffffff";
        };
      };
    in
      listToAttrs (map mkColorOption [
        "base00"
        "base01"
        "base02"
        "base03"
        "base04"
        "base05"
        "base06"
        "base07"
        "base08"
        "base09"
        "base0A"
        "base0B"
        "base0C"
        "base0D"
        "base0E"
        "base0F"
      ]);
  };
}
