{ 
config
, pkgs
, ...
}:
with config.lib.stylix.colors.withHashtag; {
  imports = [
  ];
  stylix.iconTheme = {
    enable = true;
    light = "Papirus";
    dark = "Papirus";
    package = pkgs.papirus-icon-theme;
  };
  stylix.targets.gtk = {
    extraCss = ''
     tooltip, tooltip.background {
          background-color: ${base01};
          color: ${base05};
          border-radius: 0px;
          border: 5px solid ${base02};
          box-shadow: none;
    '';
  };
}
