{
  config,
  pkgs,
  ...
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
      font-family: ${config.stylix.fonts.monospace.name};
    }

    tooltip {
      background-color: ${base01};
    }
    #custom-recording {
      color: ${base08};
      font-size: 150%;
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
        modules-center = [ ];
        modules-left = [
          "hyprland/workspaces"
          "custom/recording"
          #"pulseaudio"
        ];
        "custom/recording"= {
          "format"= "";
          "tooltip"="click to stop recording";
          "exec" = "pgrep wl-screenrec && echo 'recording'";
          "interval" = 2;
          "on-click" = "pkill wl-screenrec";
        };
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
          "format" = "{:%B %d %H:%M}";
          "format-alt" = "{:%A, %B %d, %Y (%R)} ";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          "calendar" = {
            "mode" = "month";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "format" = {
              "months" = "<span color='${base0D}'><b>{}</b></span>";
              "days" = "<span color='${base05}'><b>{}</b></span>";
              #"weeks" = "<span color='${base0C}'><b>W{}</b></span>";
              "weekdays" = "<span color='${base0C}'><b>{}</b></span>";
              "today" = "<span color='${base0E}'><b>{}</b></span>";
            };
          };
          "actions" = {
            "on-click-right" = "mode";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
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
