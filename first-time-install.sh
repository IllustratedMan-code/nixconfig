#!/usr/bin/env bash
# run this when installing nix for the first time

git clone https://github.com/doomemacs/doomemacs --depth 1 ~/.emacs.d
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
