{
  config,
  pkgs,
  ...
}:
with config.lib.stylix.colors.withHashtag;
{
  home.packages = with pkgs; [ mako ];
  xdg.configFile."mako/config".text = ''
    background-color=${base00}
    border-color=${base01}
    text-color=${base05}
    progress-color=${base02}
    default-timeout=30000

    [urgency=low]
    background-color=${base00}
    border-color=${base03}
    text-color=${base05}
    
    [urgency=high]
    background-color=${base00}
    border-color=${base08}
    text-color=${base05}

    [mode=hide]
    invisible=1
  '';
}
