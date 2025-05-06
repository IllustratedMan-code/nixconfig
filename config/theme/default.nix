{
  config,
  pkgs,
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
        sed -i 's/white/${base01}/g' ${wallpaper}.svg
        sed -i 's/black/${base0D}/g' ${wallpaper}.svg
        convert ${wallpaper}.svg ${wallpaper}.png
        mkdir $out
        cp ${wallpaper}.png $out/wallpaper.png
        cp ${wallpaper}.svg $out/wallpaper.svg
      '';
    };
  wallpaper = wallpaper_maker "atp";
in
{
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${colorscheme}.yaml";
  stylix.image = "${wallpaper}/wallpaper.png";
  stylix.cursor = {
    package = pkgs.graphite-cursors;
    name = "graphite-dark";
    size = 16;
  };
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    jetbrains-mono
  ];

  stylix.fonts = {
    serif = config.stylix.fonts.monospace;
    sansSerif = config.stylix.fonts.monospace;
    emoji = config.stylix.fonts.monospace;
    monospace = {
      name = "JetBrainsMono";
      package = pkgs.jetbrains-mono;
    };

  };
}
