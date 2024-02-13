{lib, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$container"
        "$line_break"
        "$shlvl"
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
      shlvl = {
        disabled = false;
        format = "[$symbol](@style)";
        repeat = true;
        repeat_offset = 1;
        symbol = "❯";
        threshold = 0;
      };
    };
  };
}
