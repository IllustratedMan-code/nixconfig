{ pkgs, config, ... }:
with config.lib.stylix.colors.withHashtag;
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
    ];
    profiles.default.userSettings = {
      "editor.minimap.enabled" = false;
      "window.menuBarVisibility" = "compact";
      "chat.commandCenter.enabled" = false;
      "window.commandCenter" = false;
      "workbench.layoutControl.enabled" = false;
      "keyboard.dispatch" = "keyCode"; # use os-wide rebinding

      # quarto stuff
      "quarto.cells.background.color" = "useTheme";
      "workbench.colorCustomizations" = {
        "[Stylix]" = {
          "textCodeBlock.background" = "${base01}";
          "notebook.selectedCellBackground" = "${base01}";
        };
      };
    };
  };
}
