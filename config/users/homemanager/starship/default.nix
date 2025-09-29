{ pkgs,config, ... }:
with config.lib.stylix.colors.withHashtag;
{

  stylix.targets.starship.enable = false;
  programs.starship.enable = true;
  programs.starship.settings = rec {
    add_newline = false;
    character = {
      success_symbol = "[➜](bold green)";
      error_symbol = "[➜](bold green)";
    };
  };
}
