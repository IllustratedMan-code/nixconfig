{pkgs, ...}:
{
  emacsLib.useFiles = ["languages/plantuml/+plantuml.el"];
  home.packages = with pkgs; [plantuml-c4 mermaid-cli];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      plantuml-mode
      mermaid-mode
      ob-mermaid
    ])
  );
}
