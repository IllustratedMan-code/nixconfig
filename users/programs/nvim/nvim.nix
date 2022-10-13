{inputs, config, pkgs,scheme, ... }:
    with scheme;
let
    config = builtins.readFile "${inputs.dotfiles}/.gnuplot";
    theme = ''
        let g:colors_name = 'base16'
        lua require('base16').setup({
            \ base00 = '#${base00}', base01 = '#${base01}', base02 = '#${base02}', base03 = '#${base03}',
            \ base04 = '#${base04}', base05 = '#${base05}', base06 = '#${base06}', base07 = '#${base07}',
            \ base08 = '#${base08}', base09 = '#${base09}', base0A = '#${base0A}', base0B = '#${base0B}',
            \ base0C = '#${base0C}', base0D = '#${base0D}', base0E = '#${base0E}', base0F = '#${base0F}'
            \})
    '';

    colors = ''
        return {
                base00="${base00}",
                base01="${base01}",
                base02="${base02}",
                base03="${base03}",
                base04="${base04}",
                base05="${base05}",
                base06="${base06}",
                base07="${base07}",
                base08="${base08}",
                base09="${base09}",
                base0A="${base0A}",
                base0B="${base0B}",
                base0C="${base0C}",
                base0D="${base0D}",
                base0E="${base0E}",
                base0F="${base0F}",
                }
    '';
in
{

    xdg.configFile."nvim/init.vim".source = "${inputs.dotfiles}/nvim/init.vim";
    xdg.configFile."nvim/lua" = {
     source = "${inputs.dotfiles}/nvim/lua";
     recursive = true;
    };
    xdg.configFile."nvim/coq-user-snippets" = {
     source = "${inputs.dotfiles}/nvim/coq-user-snippets";
     recursive = true;
    };
    xdg.configFile."nvim/colors/base16.vim".text = theme;
    programs.neovim = {
        enable = true;
    };
    xdg.configFile."nvim/lua/colors.lua".text = colors;
}
