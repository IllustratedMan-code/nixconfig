{ 
pkgs
, ...
}:
{
  imports = [ ./nix ./markdown ./python ./org ./typst ./R ./spelling];
  emacsLib.useFiles = [ "languages/languages.el" ];
  home.packages = with pkgs; [
    (aspellWithDicts (dicts: with dicts; [en en-computers en-science]))
    aspellDicts.en-computers
   # aspell
   # aspellDicts.en-computers
  ];
  programs.emacs.extraPackages = (
    epkgs:
    (with epkgs; [
      lsp-mode
      lsp-ivy
    ])
  );
}
