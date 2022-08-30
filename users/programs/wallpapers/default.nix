{inputs, config, pkgs, scheme, base16-wallpaper, ... }:
    with scheme.withHashtag;
let

  base16-wallpaper = pkgs.stdenv.mkDerivation {
    name = "wallpaper";
    src = ./.;
    nativeBuildInputs = [ pkgs.gnused pkgs.imagemagick];
    installPhase = ''
      sed -i 's/white/${base00}/g' atp.svg
      sed -i 's/black/${base0D}/g' atp.svg
      convert atp.svg atp.png
      mkdir $out
      cp atp.png $out/atp.png
      cp atp.svg $out/atp.svg
    '';
  };
in
{
  xdg.configFile."atp.png".source = "${base16-wallpaper}/atp.png";
  xdg.configFile."atp.svg".source = "${base16-wallpaper}/atp.svg";
}
