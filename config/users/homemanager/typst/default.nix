{pkgs, ...}:
{
  home.packages = with pkgs; [typst];
  xdg.dataFile."typst/packages/local/assignments/1.0.0".source = ./templates/assignments;

}
  
