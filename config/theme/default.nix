{
  config,
  pkgs,
  inputs,
  colorscheme,
  ...
}:
let
in
{
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${colorscheme}.yaml";
  stylix.image = ./foggy_valley.png;
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
