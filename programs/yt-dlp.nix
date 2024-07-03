{
  config,
  pkgs,
  ...
}: {
  programs.yt-dlp = {
    enable = true;
    settings = {
      all-subs = true;
      write-annotations = true;
      add-metadata = true;
      embed-subs = true;
      embed-thumbnail = true;
      merge-output-format = "mkv";
      output = "'(%(uploader)s) %(title)s.%(ext)s'";
      S = "res:1920";
    };
  };
}
