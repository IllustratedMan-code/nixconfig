{ inputs, config, pkgs, scheme, ... }:
with scheme.withHashtag;
let
  theme = ''
    * {
      color: ${base0A};
    }
    window#waybar {
      background-color: ${base01};
      border-radius: 20px;
    }
    #tray {
      color: transparent;
    }
    #workspaces {
      font-size: 150%;
    }
    #battery, #wireplumber, #backlight, #workspaces, #tray {
      margin-right: 10px;
      margin-left: 10px;
    }
  '';
in
{
  home.packages = with pkgs; [ stable.helvum ];
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [{
      position = "top";
      layer = "top";
      height = 20;
      margin-top = 5;
      margin-right = 17;
      margin-left = 17;
      modules-right = [ "tray" "clock" "battery" ];
      modules-center = [ "wlr/workspaces" ];
      modules-left = [ "backlight" "wireplumber" ];
      "wlr/workspaces" = {
        format = "{icon}";
        on-click = "activate";
        format-icons = {
          "urgent" = "";
          "active" = "";
          "default" = "";
        };
        "sort-by-number" = true;
      };
      "battery" = {
        "interval" = 60;
        "states" = {
          "warning" = 30;
          "critical" = 15;
        };
        "format" = "{icon}";
        "format-icons" = [ "🌑" "🌘" "🌗" "🌖" "🌕" ];
        "max-length" = 25;
      };

      "clock" = {
        "calendar-weeks-pos" = "right";
        "today-format" = "<span color='#ff6699'><b><u>{}</u></b></span>";
        "format-calendar" = "<span color='#ecc6d9'><b>{}</b></span>";
        "format-calendar-weeks" = "<span color='#99ffdd'><b>W{:%U}</b></span>";
        "format-calendar-weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
        "on-scroll" = {
          "calendar" = 1;
        };
      };

      "wireplumber" = {
        "format" = "Volume: {volume}%";
        "format-muted" = ".";
        "on-click" = "helvum";
      };


      #exclusive = false;
    }];
    style = theme;
  };
}

