{ inputs, config, pkgs, scheme, ... }:
with scheme.withHashtag;
let
  theme = builtins.toFile "base16.scss" ''
    $base00: ${base00};
    $base01: ${base01};
    $base02: ${base02};
    $base03: ${base03};
    $base04: ${base04};
    $base05: ${base05};
    $base06: ${base06};
    $base07: ${base07};
    $base0D: ${base08};
    $base0E: ${base09};
    $base0C: ${base0A};
    $base0A: ${base0B};
    $base09: ${base0C};
    $base0B: ${base0D};
    $base08: ${base0E};
    $base0F: ${base0F};
  '';
  base16gtk = pkgs.stdenv.mkDerivation {
    name = "base16gtk";
    src = ./.;
    nativeBuildInputs = [ pkgs.sass ];
    propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/themes/base16/gtk-2.0
      mkdir -p $out/share/themes/base16/gtk-3.0
      mkdir -p $out/share/themes/base16/gtk-4.0
      cp ${theme} gtk-3.0/base16.scss
      cp -r gtk-3.0/assets $out/share/themes/base16/gtk-3.0/assets
      sass gtk-3.0/gtk.scss $out/share/themes/base16/gtk-3.0/gtk.css
      sass gtk-4.0/gtk.scss $out/share/themes/base16/gtk-4.0/gtk.css
      runHook postInstall
    '';

  };
in
{
  gtk = {
    enable = true;
    theme = {
      name = "base16";
      package = base16gtk;
    };
    iconTheme = {
      name = "papyrus-icon-theme";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "phinger-cursors";
      package = pkgs.phinger-cursors;
    };
  };
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      package = pkgs.adwaita-qt;
      name = "Adwaita";
    };
  };

  systemd.user.sessionVariables = {
    GTK_THEME = "base16";
  };
}
