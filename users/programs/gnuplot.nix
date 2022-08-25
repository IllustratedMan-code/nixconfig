{inputs, config, pkgs, scheme, ... }:
    with scheme.withHashtag; 
let
    config = builtins.readFile "${inputs.dotfiles}/.gnuplot";
    theme =  ''
        set border lw 3 lc rgb "${base0D}"
        set key textcolor rgb "${base0D}"
        set linetype 1 lc rgb "${base08}" lw 5 pt 1
        set linetype 2 lc rgb "${base09}" lw 5 pt 1
        set linetype 3 lc rgb "${base0A}" lw 5 pt 1
        set linetype 4 lc rgb "${base0B}" lw 5 pt 1
        set linetype 5 lc rgb "${base0E}" lw 5 pt 1
        set linetype cycle 5
    '';
in
{
   xdg.configFile."gnuplot".text = config + theme;
}
