{ inputs
, config
, pkgs
, scheme
, ...
}:
{
  programs.kitty = {
    enable = true;
    extraConfig = ''
      linux_display_server X11
      window_padding_width 4
      confirm_os_window_close 0
      enable_audio_bell no
    '';
  };
}
