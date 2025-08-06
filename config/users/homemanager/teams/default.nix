{pkgs, ...}:
let
  browser = pkgs.lib.getExe pkgs.chromium;
in
{
  xdg.desktopEntries.teams = {
    name = "Teams";
    exec = "${browser} --app=https://teams.microsoft.com/v2/ --ozone-platform=wayland";
    type = "Application";
    icon = "teams";
  };
}
