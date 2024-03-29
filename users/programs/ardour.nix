{ inputs, config, pkgs, scheme, ... }:
{
  home.packages = with pkgs; [
    ardour
    tunefish
    swh_lv2
    mda_lv2
    calf
    gxplugins-lv2
  ];
  systemd.user.sessionVariables = {
    DSSI_PATH = "$HOME/.dssi:$HOME/.nix-profile/lib/dssi:/run/current-system/sw/lib/dssi:/etc/profiles/per-user/$USER/lib/dssi";
    LADSPA_PATH = "$HOME/.ladspa:$HOME/.nix-profile/lib/ladspa:/run/current-system/sw/lib/ladspa:/etc/profiles/per-user/$USER/lib/ladspa";
    LV2_PATH = "$HOME/.lv2:$HOME/.nix-profile/lib/lv2:/run/current-system/sw/lib/lv2:/etc/profiles/per-user/$USER/lib/lv2";
    LXVST_PATH = "$HOME/.lxvst:$HOME/.nix-profile/lib/lxvst:/run/current-system/sw/lib/lxvst:/etc/profiles/per-user/$USER/lib/lxvst";
    VST_PATH = "$HOME/.vst:$HOME/.nix-profile/lib/vst:/run/current-system/sw/lib/vst:/etc/profiles/per-user/$USER/lib/vst";
  };
}
