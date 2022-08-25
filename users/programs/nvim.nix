{inputs, config, pkgs, ... }:
    with config.scheme.withHashtag; 
let
    config = builtins.readFile "${inputs.dotfiles}/.gnuplot";
    theme = ''
        set border lw 3 lc rgb "${Base0D}"
        set key textcolor rgb "${Base0D}"
        set linetype 1 lc rgb "${Base08}" lw 5 pt 1
        set linetype 2 lc rgb "${Base09}" lw 5 pt 1
        set linetype 3 lc rgb "${Base0A}" lw 5 pt 1
        set linetype 4 lc rgb "${Base0B}" lw 5 pt 1
        set linetype 5 lc rgb "${Base0E}" lw 5 pt 1
        set linetype cycle 5
    '';
in
{
   xdg.configFile."gnuplot".text = config + theme;
}
