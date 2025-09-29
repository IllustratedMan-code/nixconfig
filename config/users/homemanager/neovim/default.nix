{pkgs, ...}:
{
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
  xdg.configFile."nvim/lua/main.lua".source = ./main.lua;
  xdg.configFile."nvim/lua/keymap.lua".source = ./keymap.lua;
  xdg.configFile."nvim/lua/lsp.lua".source = ./keymap.lua;
}
