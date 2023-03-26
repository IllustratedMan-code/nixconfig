{ config, pkgs, ... }:
let
  wrap = program: exe: pkgs.symlinkJoin rec {
    name = program.name;
    paths = [ program ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/${exe} --set __NV_PRIME_RENDER_OFFLOAD 1 --set __NV_PRIME_RENDER_OFFLOAD_PROVIDER NVIDIA-G0 --set __GLX_VENDOR_LIBRARY_NAME nvidia --set __VK_LAYER_NV_optimus NVIDIA_only
    '';
  };
in
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
        microsoft-edge = wrap super.microsoft-edge "microsoft-edge";
      })
  ];

}
