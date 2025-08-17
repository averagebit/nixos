{pkgs, ...}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --remember --remember-user-session --user-menu --time --time-format '%I:%M %p | %a • %h | %F' --cmd bash";
      };
    };
  };
}
