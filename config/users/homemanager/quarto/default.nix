{pkgs, ...}:
let
  myquarto = pkgs.quarto.override {
    extraRPackages = with pkgs.rPackages; [
      DBI
      RSQLite
    ];
  };
in
{
  home.packages = [myquarto];
}
