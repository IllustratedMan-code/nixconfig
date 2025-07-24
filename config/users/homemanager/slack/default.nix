{pkgs, ...}:
let
  browser = pkgs.lib.getExe pkgs.chromium;
in
{
  xdg.desktopEntries.slack = {
    name = "Slack";
    exec = "${browser} --app=https://app.slack.com/client";
    type = "Application";
    icon = "slack";
  };
}
