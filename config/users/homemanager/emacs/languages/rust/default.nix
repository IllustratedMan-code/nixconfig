{...}:
{
  emacsLib.useFiles = ["languages/rust/+rust.el"];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      rust-mode
    ])
  );
}
