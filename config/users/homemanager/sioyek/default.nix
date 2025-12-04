{ config, ... }:
with config.lib.stylix.colors.withHashtag;
{
  programs.sioyek = {
    enable = true;
    bindings = {
      "open_document_embedded" = "o";
      "toggle_custom_color" = "c";
    };
    config = {
      "custom_background_color" = "${base00}";
      "custom_color_mode_empty_background_color" = "${base01}";
      "custom_text_color" = "${base06}";
      "page_separator_color" = "${base01}";
      "search_highlight_color" = "${base0A}";
      "status_bar_color" = "${base00}";
      "status_bar_text_color" = "${base06}";
      "ui_text_color" = "${base06}";
      "ui_selected_text_color" = "${base06}";
      "ui_background_color" = "${base01}";
      "ui_selected_background_color" = "${base03}";
      "background_color" = "${base01}";
      "visual_mark_color" = "${base03-dec-r} ${base03-dec-g} ${base03-dec-b} 0.2";
      "text_highlight_color" = "${base03}";
      "link_highlight_color" = "${base0D}";
      "synctex_highlight_color" = "${base08}";
      "startup_commands" = "toggle_custom_color;";
      "page_separator_width" = "15";

    };
  };
}
