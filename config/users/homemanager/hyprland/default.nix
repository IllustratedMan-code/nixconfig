{ inputs
, config
, pkgs
, lib
, ...
}:
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
  screenshot = with pkgs; writeShellApplication {
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
        systemd.variables = ["--all"];
        extraConfig = ''
          $mod = SUPER # Sets "Windows" key as main modifier
          $modshift = $mod + SHIFT
          exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
          exec-once = nm-applet
          ${sourcelines}
        '';
        plugins = [
          pkgs.hyprlandPlugins.hyprscrolling
        ];
        xwayland.enable = true;
      };
    };
}
