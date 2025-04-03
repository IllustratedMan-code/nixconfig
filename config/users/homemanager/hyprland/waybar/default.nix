{ inputs
, config
, pkgs
, ...
}:
with config.lib.stylix.colors.withHashtag;
let
  theme = ''
    window#waybar {
      background-color: ${base00};
    }
    #tray {
      color: transparent;
    }
    #battery, #pulseaudio, #backlight, #workspaces, #tray, #clock, #window {
      font-size: 100%;
      margin-right: 10px;
      margin-left: 10px;
      color: ${base05}
    }
    #battery.critical {
      color: ${base08};
    }
    #workspaces button.active {
      border-bottom: 0.1rem solid ${base05};
      background: ${base02};
      border-radius: 0.1rem;
    }
    #workspaces button.urgent {
      color: ${base08};
    }
    #workspaces button:hover {
      background: transparent;
      color: ${base06}
    }
    #workspaces button.hosting-monitor {
      color: ${base0B}
    }
    * {
      font-family: "JetBrainsMono Nerd Font Mono";
    }
  '';

in
{
  hyprland.configs = [ "waybar/waybar-hyprland.conf" ];
  stylix.targets.waybar.enable = false;
  home.packages = with pkgs; [
    helvum
    sqlite
  ];
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        position = "top";
        layer = "top";
        height = 36;
        #margin-top = 5;
        #margin-right = 17;
        #margin-left = 17;
        modules-right = [
          "tray"
          "clock"
          "battery"
        ];
        modules-center = [];
        modules-left = [
					"hyprland/workspaces" 
          #"backlight"
          #"pulseaudio"
        ];
        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            #"urgent" = "";
            #"active" = "";
            #"default" = "";
          };
          "persistent-workspaces" = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
          };
          "sort-by" = "number";
        };
        "battery" = {
          "interval" = 60;
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{icon}";
          "format-icons" = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          "format-charging" = "{icon}󱐋";
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

        "pulseaudio" = {
          "format" = "{icon}";
          "format-muted" = "";
          "on-click" = "helvum";
          "format-icons" = {
            "default" = [
              " ━┅┅┅┅┅┅┅┅┅"
              " ━━┅┅┅┅┅┅┅┅"
              " ━━━┅┅┅┅┅┅┅"
              " ━━━━┅┅┅┅┅┅"
              " ━━━━━┅┅┅┅┅"
              " ━━━━━━┅┅┅┅"
              " ━━━━━━━┅┅┅"
              " ━━━━━━━━┅┅"
              " ━━━━━━━━━┅"
              " ━━━━━━━━━━"
            ];
          };
        };
        "backlight" = {
          "on-scroll-up" = "light -A 5";
          "on-scroll-down" = "light -U 5";
          "format" = "{icon}";
          "format-icons" = [
            "󱩎 ━┅┅┅┅┅┅┅┅┅"
            "󱩏 ━━┅┅┅┅┅┅┅┅"
            "󱩐 ━━━┅┅┅┅┅┅┅"
            "󱩑 ━━━━┅┅┅┅┅┅"
            "󱩒 ━━━━━┅┅┅┅┅"
            "󱩓 ━━━━━━┅┅┅┅"
            "󱩔 ━━━━━━━┅┅┅"
            "󱩕 ━━━━━━━━┅┅"
            "󱩖 ━━━━━━━━━┅"
            "󰛨 ━━━━━━━━━━"
          ];
        };

      }
    ];
    style = theme;
  };
}
