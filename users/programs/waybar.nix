{ inputs, config, pkgs, scheme, ... }:
with scheme.withHashtag;
let
  theme = ''
    * {
      color: ${base0A};
    }
    window#waybar {
      background-color: ${base01};
      border-radius: 10px;
    }
    #tray {
      color: transparent;
      margin-right: 5px;
      margin-left: 5px;
    }
    #tray:hover {
      background: red;
    }
    #workspaces {
      margin-right: 5px;
      margin-left: 5px;
      font-size: 150%;
    }
    #battery {
      margin-right: 5px;
      margin-left: 5px;
    }
    #wireplumber {
      margin-right: 5px;
      margin-left: 5px;
    }
    #backlight {
      margin-right: 5px;
      margin-left: 5px;
    }

  '';
in
{
  home.packages = with pkgs; [ helvum ];
  programs.waybar = {
    enable = true;
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
        "format-icons" = [ "🔈" ];
      };

      "backlight" = {
        "device" = "intel_backlight";
        "format" = "{icon}: {percent}%";
        "format-icons" = [ "🔅" "🔆" ];
      };

      #exclusive = false;
    }];
    style = theme;
  };
}

