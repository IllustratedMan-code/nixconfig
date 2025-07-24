{ inputs
, config
, pkgs
, ...
}:
{
  # language servers not managed by project flakes
  home.packages = with pkgs; [
    nil
  ];
  programs.helix = {
    enable = true;
    package = pkgs.unstable.helix;
    settings = {
      theme = pkgs.lib.mkForce "everforest_dark";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
      }
    ];
  };
}
