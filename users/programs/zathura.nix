{ inputs, config, pkgs, scheme, ... }:
with scheme.withHashtag;
let
  theme = ''
    set default-bg                  "${base00}"
    set default-fg                  "${base01}"
    set statusbar-fg                "${base04}"
    set statusbar-bg                "${base02}"
    set inputbar-bg                 "${base00}"
    set inputbar-fg                 "${base07}"
    set notification-bg             "${base00}"
    set notification-fg             "${base07}"
    set notification-error-bg       "${base00}"
    set notification-error-fg       "${base08}"
    set notification-warning-bg     "${base00}"
    set notification-warning-fg     "${base08}"
    set highlight-color             "${base0A}"
    set highlight-active-color      "${base0D}"
    set completion-bg               "${base01}"
    set completion-fg               "${base0D}"
    set completion-highlight-fg     "${base07}"
    set completion-highlight-bg     "${base0D}"
    set recolor-lightcolor          "${base00}"
    set recolor-darkcolor           "${base06}"
  '';
in
{
  xdg.configFile."zathura/zathurarc".source = "${inputs.dotfiles}/zathura/zathurarc";
  xdg.configFile."zathura/base16.conf".text = theme;
}
