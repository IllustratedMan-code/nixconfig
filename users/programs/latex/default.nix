{ config, pkgs, inputs, ... }:
{
  home.file."texmf/tex/latex/custom/assignments.cls".source = ./assignments.cls;
}
