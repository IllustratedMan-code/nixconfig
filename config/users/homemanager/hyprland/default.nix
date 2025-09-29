{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
with config.lib.stylix.colors;
let
  makeConfig =
    path:
    let
      fullpath = "${config.home.homeDirectory}/nixconfig/config/users/homemanager/hyprland/${path}";
    in
    ({
      "hypr/${path}".source = config.lib.file.mkOutOfStoreSymlink fullpath;
    });
  trace = arg: builtins.trace arg arg;
  screenshot =
    with pkgs;
    writeShellApplication {
      name = "screenshot";
      text = ''
        if [[ $# -ge 1 ]]; then
           dir="$1"
        else
           dir="$HOME/Pictures"
        fi

        echo "$dir" > "$HOME/.screenshots"
      '';
    };

in
{
  imports = [
    ./waybar
    ./rofi
    ./mako
    ./swayosd
  ];

  options.hyprland = {
    configs = lib.mkOption {
      default = [ "main.conf" ];
    };

  };

  config =
    let
      configfiles = (
        builtins.foldl' (x: y: x // y) { } (builtins.map makeConfig config.hyprland.configs)
      );
      sourcelines = builtins.foldl' (x: y: "${x}\n${y}") "" (
        builtins.map (x: "source=${x}") config.hyprland.configs
      );


      theme = ''
        $base00 = 0xff${base00}
        $base01 = 0xff${base01}
        $base02 = 0xff${base02}
        $base03 = 0xff${base03}
        $base04 = 0xff${base04}
        $base05 = 0xff${base05}
        $base06 = 0xff${base06}
        $base07 = 0xff${base07}
        $base08 = 0xff${base08}
        $base09 = 0xff${base09}
        $base0A = 0xff${base0A}
        $base0B = 0xff${base0B}
        $base0C = 0xff${base0C}
        $base0D = 0xff${base0D}
        $base0E = 0xff${base0E}
        $base0F = 0xff${base0F}
      '';
    in
    {

      hyprland.configs = [
        "main.conf"
        "kitty.conf"
        "emacs.conf"
        "blueman.conf"
        "home-monitors.conf"
      ];
      xdg.configFile = configfiles;
      home.packages = with pkgs; [
        wl-screenrec
        wf-recorder
        screenshot
        hyprpicker
        nwg-displays
        wl-clipboard
        hyprpolkitagent
        networkmanagerapplet
        grim
        slurp
        pavucontrol
      ];
      wayland.windowManager.hyprland = {
        enable = true;
        systemd.variables = [ "--all" ];
        extraConfig = ''
          $mod = SUPER # Sets "Windows" key as main modifier
          $modshift = $mod + SHIFT
          exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
          exec-once = nm-applet
          ${theme}
          ${sourcelines}
        '';
        xwayland.enable = true;
      };
    };
}
