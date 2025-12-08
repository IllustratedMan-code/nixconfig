{
  config,
  pkgs,
  lib,
  ...
}:
with config.lib.stylix.colors.withHashtag;
let
  colorscheme = "everforest";
  wallpaper_maker =
    wallpaper:
    pkgs.stdenv.mkDerivation {
      name = "wallpaper";
      src = ./.;
      nativeBuildInputs = [
        pkgs.gnused
        pkgs.imagemagick
      ];
      installPhase = ''
        sed -i 's/white/${base00}/g' ${wallpaper}.svg
        sed -i 's/black/${base0B}/g' ${wallpaper}.svg
        convert ${wallpaper}.svg ${wallpaper}.png
        mkdir $out
        cp ${wallpaper}.png $out/wallpaper.png
        cp ${wallpaper}.svg $out/wallpaper.svg
      '';
    };
  wallpaper = wallpaper_maker "atp";
in
{
  options.theme = lib.mkOption {
    default = "everforest";
  };

  config = {
    home-manager.sharedModules = [
      {
        options.theme = lib.mkOption {
          default = config.theme;
        };
      }
    ];

    home-manager.extraSpecialArgs = {
      inherit (config) theme;
    };
    stylix.enable = true;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.theme}.yaml";
    stylix.image = "${wallpaper}/wallpaper.png";
    stylix.cursor = {
        package = pkgs.gruppled-white-cursors;
        name = "gruppled_white";
        size = 16;
    };
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      dejavu_fonts
      corefonts
    ];
    fonts.fontconfig.enable = true;

    stylix.fonts = {
        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;
        emoji = config.stylix.fonts.monospace;
        monospace = {
        name = "JetBrainsMono Nerd Font Mono";
        package = pkgs.nerd-fonts.jetbrains-mono;
        };

    };
  };
}
