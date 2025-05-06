{config, pkgs, ...}:
with config.lib.stylix.colors.withHashtag;
{
  home.packages = with pkgs; [ vesktop ];


}
