{
  programs.mpv = {
    enable = true;

    config = {
      # Default profile
      profile = "gpu-hq";
      # GPU API
      gpu-api = "vulkan";
      # Status message.
      term-status-msg = "Time: \${time-pos}";
      # Native fullscreen (MacOS only).
      native-fs = false;
      # Don't autohide the cursor in window mode, only fullscreen.
      cursor-autohide-fs-only = false;
      # Autohide the curser after 1s.
      cursor-autohide = 800;
      # Hide volume bar.
      osd-bar = false;
      # Disable borders.
      border = false;
      # If set to no will always stretch the video to window size, and will
      # disable the window manager hints that force the window aspect ratio.
      keepaspect = false;
      # Will add black bars if window aspect and video aspect mismatch.
      # Whether this actually works depends on the VO backend. (Ignored in
      # fullscreen mode.)
      keepaspect-window = false;
      # Save video position on quit.
      save-position-on-quit = true;
      # Directory to save video positions in.
      watch-later-directory = "~/.cache/mpv/watch-later";
      # Set volume to 100% on startup.
      volume = 100;
      # Set player max vol to 100%.
      volume-max = 100;

      # Set max streaming quality to 1080p
      ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
      # Max pre-load for network streams (1 MiB = 1048576 Bytes).
      demuxer-max-bytes = 150000000;
      # Max loaded video kept after playback.
      demuxer-max-back-bytes = 75000000;
      # Force stream to be seekable even if disabled.
      force-seekable = "yes";
    };

    profiles = {
      "480" = {
        ytdl-format = "bestvideo[height<=?480][fps<=?30][vcodec!=?vp9]+bestaudio/best[height<=?480]";
      };
      "720" = {
        ytdl-format = "bestvideo[height<=?720][fps<=?30][vcodec!=?vp9]+bestaudio/best[height<=?720]";
      };
      "1080" = {
        ytdl-format = "bestvideo[height<=?1080][fps<=?60][vcodec!=?vp9]+bestaudio/best[height<=?1080]";
      };
      "best" = {
        ytdl-format = "bestvideo[vcodec!=vp9]+bestaudio/best";
      };
    };
  };
}
