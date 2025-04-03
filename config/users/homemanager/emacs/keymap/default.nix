{ inputs
, config
, pkgs
, ...
}:
{
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      general
    ])
  );
}
