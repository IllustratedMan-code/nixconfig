{pkgs, ...}: # a basic clang setup for interactive use
let
in
{
  home.packages = with pkgs;[
    clang
  ];

}
