{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [ pkgs.citrix_workspace ];
  nixpkgs.overlays = [
    (self: super:
    let 
        extraCerts = [./CCHMCRootCA.crt];
    in
      {
        citrix_workspace = super.citrix_workspace.override { 
        inherit extraCerts;
            };
      })
  ];
}
