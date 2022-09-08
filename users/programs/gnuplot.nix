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
        set style line 1 lt 1 lc rgb '${base08}'
        set style line 2 lt 1 lc rgb '${base0A}'
        set style line 3 lt 1 lc rgb '${base0B}'
        set style line 4 lt 1 lc rgb '${base0C}'
        set style line 5 lt 1 lc rgb '${base0D}'
        set style line 6 lt 1 lc rgb '${base0E}'
        set style line 7 lt 1 lc rgb '${base09}'
        set style line 8 lt 1 lc rgb '${base06}'

        # palette
        set palette defined ( 0 '#FFF5F0',\
                              1 '#FEE0D2',\
                              2 '#FCBBA1',\
                              3 '#FC9272',\
                              4 '#FB6A4A',\
                              5 '#EF3B2C',\
                              6 '#CB181D',\
                              7 '#99000D' )
    '';
in
{
   xdg.configFile."gnuplot/base16.pal".text = theme;
   home.file.".gnuplot".source = "${inputs.dotfiles}/.gnuplot";
}
