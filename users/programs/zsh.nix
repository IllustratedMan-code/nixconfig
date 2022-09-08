{ inputs, config, pkgs, scheme, ... }:
with scheme.withHashtag;
let
  in
{
  programs.zsh = {
    enable = true;
    initExtra = builtins.readFile "${inputs.dotfiles}/.zshrc";
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    defaultKeymap = "viins";
    oh-my-zsh = {
      enable = true;
      plugins = [
        "colorize"
        "vi-mode"
        "zsh-navigation-tools"
        "zsh-interactive-cd"
      ];
      theme = "agnoster";
      extraConfig = ''
        # vi-mode
        VI_MODE_SET_CURSOR=true
        KEYTIMEOUT=20
      '';
    };

  };
  programs.fzf = {
    enable = true;
  };
  home.packages = with pkgs; [wl-clipboard];
}

  #home.file.".zshrc" = {
  #  source = "${inputs.dotfiles}/.zshrc";
  #};
