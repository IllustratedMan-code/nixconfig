{inputs, config, pkgs, scheme, ... }:
    with scheme;
let
    theme =  ''
      $base00 = ${base00}
      $base01 = ${base01}
      $base02 = ${base02}
      $base03 = ${base03}
      $base04 = ${base04}
      $base05 = ${base05}
      $base06 = ${base06}
      $base07 = ${base07}
      $base08 = ${base08}
      $base09 = ${base09}
      $base0A = ${base0A}
      $base0B = ${base0B}
      $base0C = ${base0C}
      $base0D = ${base0D}
      $base0E = ${base0E}
      $base0F = ${base0F}
    '';
in
{
  imports = [inputs.hyprland.homeManagerModules.default];
  xdg.configFile."hypr/hyprland_config.conf".source = "${inputs.dotfiles}/hypr/hyprland.conf";
  xdg.configFile."hypr/colors.conf".text = theme;
  xdg.configFile."hypr/hyprpaper.conf".source = "${inputs.dotfiles}/hypr/hyprpaper.conf";
  home.packages = with pkgs; [wl-clipboard];
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      source=~/.config/hypr/hyprland_config.conf
    '';
  };
}
