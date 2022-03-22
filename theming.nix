{ config, pkgs, inputs, ... }:
{
    home-manager.users.david = {
        xdg.configFile."zathura/zathurarc" = {
          text = builtins.readFile(./dotfiles/zathura/zathurarc) +
          builtins.readFile (config.scheme inputs.base16-zathura);
        };
    };
}
