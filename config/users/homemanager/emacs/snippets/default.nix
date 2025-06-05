{...}:
{
  emacsLib.useFiles = ["snippets/+snippets.el"];
  programs.emacs.extraPackages = (
    epkgs: (with epkgs; [
      yasnippet
    ])
  );
}
