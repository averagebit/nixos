{pkgs, ...}: {
  imports = [
    ./awscli
    ./jira
    ./lynx
  ];

  home.packages = with pkgs; [
    cam # Android cam setup wrapper
    open # Wrapper around xdg-open
    scratch # Terminal scratchpad
    yank # Copy utility
    yt-dlp # YouTube downloader
  ];
}
