{ 
 pkgs
, ...
}:
let
  fzf-preview = pkgs.writeShellApplication {
    runtimeInputs = with pkgs; [
      file
      bat
    ];
    name = "fzf-preview";
    text = ''
    ${builtins.readFile ./fzf-preview.sh}
    '';
  };
in
{
  home.packages = with pkgs; [pdftk
                              fzf-preview
                             ];
  programs.bat.enable = true;
  programs.fzf.enable = true;
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
      fzfp = "fzf --style full --preview 'fzf-preview {}'";
      bfzf = "bat $(fzf)";
    };
    initContent = pkgs.lib.mkAfter (builtins.readFile ./zshrc.sh);
  };
}
