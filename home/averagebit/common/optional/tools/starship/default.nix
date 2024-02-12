{lib, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$shlvl"
        "$directory"
        "$git_branch"
        "$container"
        "$line_break"
        "$character"
      ];
      username = {
        format = "[$user]($style)[@]($style)";
        style_user = "bold yellow";
      };
      hostname = {
        format = "[$hostname]($style):";
        style = "bold yellow";
      };
      directory = {
        style = "bold blue";
      };
    };
  };
}
