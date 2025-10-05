{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.qutebrowser = {
    enable = true;
    settings = {
      content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101 Firefox/68.0";
      content.headers.accept_language = "en-US,en;q=0.5";
      auto_save.session = true;
      content.webgl = false;
      content.javascript.enabled = false;
      window.hide_decoration = true;
      colors.webpage.darkmode.enabled = true;
      zoom.default = "125%";
      content.canvas_reading = false;
    };
  };
}
