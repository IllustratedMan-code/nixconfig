{ inputs, config, pkgs, scheme, vimUtils, lib, ... }:
with scheme;
let
  theme = ''
    lua require('base16-colorscheme').setup({
        \ base00 = '#${base00}', base01 = '#${base01}', base02 = '#${base02}', base03 = '#${base03}',
        \ base04 = '#${base04}', base05 = '#${base05}', base06 = '#${base06}', base07 = '#${base07}',
        \ base08 = '#${base08}', base09 = '#${base09}', base0A = '#${base0A}', base0B = '#${base0B}',
        \ base0C = '#${base0C}', base0D = '#${base0D}', base0E = '#${base0E}', base0F = '#${base0F}'
        \})
  '';
  dotfile = filepath: builtins.readFile "${inputs.dotfiles}/nvim/lua/${filepath}";
in
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = dotfile "plugins/lsp.lua";
      }
      {
        plugin = nvim-lightbulb;
        config = dotfile "plugins/lightbulb.vim";
      }
      lsp-status-nvim
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = dotfile "plugins/gitsigns.lua";
      }
      nvim-ts-rainbow
      {
        plugin = (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars));
        type = "lua";
        config = dotfile "plugins/treesitter.lua";

      }
      {
        plugin = nvim-base16;
        config = theme;
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = dotfile "plugins/lualine.lua";
      }
      {
        plugin = vim-choosewin;
        config = dotfile "plugins/choosewin.vim";
      }
      telescope-nvim
      telescope-file-browser-nvim
      telescope-project-nvim
      {
        plugin = which-key-nvim;
        type = "lua";
        config = dotfile "plugins/whichkey.lua";
      }
      neorg
      plenary-nvim
      {
        plugin = nvim-cmp;
        type = "lua";
        config = dotfile "plugins/completion.lua";
      }
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      friendly-snippets
      vim-snippets
      {
        plugin = luasnip;
        type = "lua";
        config = dotfile "plugins/luasnip.lua";
      }
      cmp_luasnip
      neogit
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = dotfile "plugins/tree.lua";
      }
      nvim-web-devicons
    ];
    extraPackages = with pkgs; [
      sumneko-lua-language-server
      nodePackages.pyright
      haskell-language-server
      nodePackages.bash-language-server
      rnix-lsp
      texlab
      rust-analyzer
      rPackages.languageserver
      nodePackages.eslint
      nodePackages.vscode-langservers-extracted
      ltex-ls
    ];
    withPython3 = true;
    withNodeJs = true;
    extraConfig = dotfile "config.vim";
  };
  # sync snippets dir
}
