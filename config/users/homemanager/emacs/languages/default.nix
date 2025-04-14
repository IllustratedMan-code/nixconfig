{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [ ./nix ];

  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
    ])
  );
}
