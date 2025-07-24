{pkgs, ...}:
let
  browser = pkgs.lib.getExe pkgs.chromium;
in
{
  xdg.desktopEntries.slack = {
    name = "Outlook";
    exec = "${browser} --app=https://outlook.office365.com/mail/";
    type = "Application";
    icon = "outlook";
  };
}
