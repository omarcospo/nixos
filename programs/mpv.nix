{
  config,
  pkgs,
  ...
}: {
  programs.mpv = {
    enable = true;
    config = {
      # Session
      save-position-on-quit = "yes";
      resume-playback = "yes";

      # Video
      video-sync = "display-resample";
      gpu-context = "wayland";
      hwdec = "auto-safe";
      hwdec-codecs = "h264,vc1,hevc,vp8,vp9";

      # Audio
      af = "lavfi=[dynaudnorm=f=75:g=25:p=0.55]";

      # Window
      autofit-larger = "60%x60%";

      # Screenshot
      screenshot-directory = "~/Pictures/MPV";
      screenshot-template = "%F - %p";

      # Scripts
      script-opts = "ytdl_hook-ytdl_path=yt-dlp";
      ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
    };
    scripts = with pkgs.mpvScripts; [
      uosc
      thumbfast
      mpris
      webtorrent-mpv-hook
    ];
    bindings = {
      # Menu bindings
      menu = "script-binding uosc/menu";
      mbtn_right = "script-binding uosc/menu";
      mbtn_left = "cycle pause";

      # File and subtitle bindings
      o = "script-binding uosc/open-file"; #! Open file
      "Alt+s" = "script-binding uosc/load-subtitles"; #! Load subtitles
      s = "script-binding uosc/subtitles"; #! Select subtitles
      A = "script-binding uosc/audio"; #! Select audio
      "Ctrl+s" = "async screenshot"; #! Utils > Screenshot
      p = "script-binding uosc/playlist"; #! Utils > Playlist
      c = "script-binding uosc/chapters"; #! Utils > Chapters
      "[" = "script-binding uosc/prev"; #! Open previous
      "]" = "script-binding uosc/next"; #! Open next
      q = "quit";

      # Seek bindings
      h = "seek -10";
      l = "seek 10";
      "Ctrl+h" = "add chapter -1";
      "Ctrl+l" = "add chapter 1";

      # Speed bindings
      "}" = "add speed 0.2";
      "{" = "add speed -0.2";

      # Volume bindings
      k = "add volume 3";
      j = "add volume -3";

      # Ignore bindings
      e = "ignore";
      w = "ignore";
      d = "ignore";
      r = "ignore";
      t = "ignore";
      u = "ignore";
      "Shift+s" = "ignore";

      # Wheel bindings
      WHEEL_UP = "ignore";
      WHEEL_DOWN = "ignore";
      WHEEL_RIGHT = "ignore";
      WHEEL_LEFT = "ignore";
    };
  };
}
