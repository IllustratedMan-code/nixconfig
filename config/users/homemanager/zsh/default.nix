{ inputs
, config
, pkgs
, scheme
, ...
}:
{
  home.packages = with pkgs; [pdftk];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 10000;
      ignoreAllDups = true;
      path = "$HOME/.zsh_history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixconfig";
    };

    #extraConfig = builtins.readFile ./zshrc.sh;
  };
}
