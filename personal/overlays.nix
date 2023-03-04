{ config, pkgs, ... }:
{
  nixpkgs.overlays = [
    (self: super:
      {
        chromium = super.chromium.override {
          commandLineArgs = [
            "--use-gl=desktop"
          ];
        };
        google-chrome-beta = super.google-chrome-beta.override {
          commandLineArgs = [
            "--use-gl=desktop"
          ];
        };
      })
  ];
}
