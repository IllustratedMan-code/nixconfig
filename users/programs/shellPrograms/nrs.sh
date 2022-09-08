
(cd ~/dotfiles && git add . && git commit -m "nix change" && git push)
(cd ~/nixconfig && nix flake lock --update-input dotfiles)
nixos-rebuild switch --flake $HOME/nixconfig --use-remote-sudo
