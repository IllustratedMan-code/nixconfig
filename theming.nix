{ config, pkgs, inputs, ... }:
{
  home-manager.users.david.programs.zathura.extraConfig =
    builtins.readFile (config.scheme inputs.base16-zathura);
}
