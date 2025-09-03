{pkgs, ...}:
{
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  programs.steam = {
    gamescopeSession = true;
  };

  hardware.xone.enable = true; #xbox 1 controller support

  services.getty.autologinUser = "stix";
  environment = {
    systemPackages = pkgs.mangohud;
    loginShellInit = ''
    [[ "$(tty)" = "/dev/tty1" ]] && ${./gs.sh}
  '';
  };
  
}
