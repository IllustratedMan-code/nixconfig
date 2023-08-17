{ inputs, config, pkgs, scheme, ... }:
with scheme.withHashtag;
let
  theme = ''
    window#waybar {
      background-color: ${base01};
      border-radius: 20px;
    }
    #tray {
      color: transparent;
    }
    #battery, #pulseaudio, #backlight, #workspaces, #tray, #clock, #custom-pomodoro, #window {
      font-size: 150%;
      margin-right: 10px;
      margin-left: 10px;
      color: ${base05}
    }
    #battery.critical {
      color: ${base08};
    }
    #workspaces button.urgent {
      color: ${base08};
    }
    #workspaces button:hover {
      background: transparent;
      color: ${base06}
    }
    * {
      font-family: "JetBrainsMono Nerd Font Mono";
    }
  '';

in
{
  home.packages = with pkgs; [ stable.helvum sqlite ];
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    systemd.enable = true;
    settings = [{
      position = "top";
      layer = "top";
      height = 36;
      margin-top = 5;
      margin-right = 17;
      margin-left = 17;
      modules-right = [ "tray" "clock" "battery" ];
      modules-center = [ "wlr/workspaces" ];
      modules-left = [ "backlight" "pulseaudio" ];
      "wlr/workspaces" = {
        format = "{icon}";
        on-click = "activate";
        format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "urgent" = "";
          "active" = "";
          "default" = "";
        };
        "persistent_workspaces" = {
          "1" = "[]";
          "2" = "[]";
          "3" = "[]";
          "4" = "[]";
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
        "format-icons" = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
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

      "custom/pomodoro" = {
        "exec" = "${inputs.dotfiles}/polybar/pomodoro.sh";
        "restart-interval" = 1;
      };
      #exclusive = false;
    }];
    style = theme;
  };
}

