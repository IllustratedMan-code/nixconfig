{pkgs, config, ...}:
let
  symlink = config.pathUtils.symlink "neovim";
in
{
  imports = [../utility-modules];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      mini-nvim
      firenvim
    ];
    extraConfig = ''
    '';
    extraLuaConfig = ''
    require("main")
    '';
  };
  xdg.configFile."nvim/lua/main.lua".source = symlink ./main.lua;
  xdg.configFile."nvim/lua/keymap.lua".source = symlink ./keymap.lua;
  xdg.configFile."nvim/lua/lsp.lua".source = symlink ./lsp.lua;
}
