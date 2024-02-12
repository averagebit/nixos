{pkgs, ...}: {
  services.greetd = {
    enable = true;
    vt = 2;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --remember-user-session --user-menu --time --time-format '%I:%M %p | %a • %h | %F' --cmd bash";
      };
    };
  };
}
