{pkgs, ...}:
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
    };
  };
}
