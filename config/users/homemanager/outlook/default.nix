{pkgs, ...}:
let
  browser = pkgs.lib.getExe pkgs.chromium;
in
{
  xdg.desktopEntries.outlook = {
    name = "Outlook";
    genericName = "mail";
    exec = "${browser} --app=https://outlook.office365.com/mail/ --ozone-platform=wayland";
    type = "Application";
    icon = "ms-outlook";
  };
}
