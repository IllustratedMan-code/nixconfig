{ inputs
, config
, pkgs
, scheme
, ...
}:
{
  programs.kitty = {
    enable = true;


    #linux_display_server X11
    extraConfig = ''
      bold_font auto
      italic_font auto
      bold_italic_font auto
      window_padding_width 4
      confirm_os_window_close 0
      enable_audio_bell no
      map ctrl+shift-u no_op
    '';
  };
}
