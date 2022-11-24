# Put into home manager -> home.services.dunst.
{ pkgs, colors, ... }:
let
  mkFormat = appNameColor:
    ''<span foreground='${appNameColor}' weight='bold'>%a</span> %s\n<span size='10pt'>%b</span>'';
in
{
  enable = true;
  iconTheme = {
    package = pkgs.tela-icon-theme;
    name = "Tela";
  };
  settings = {
    global = {
      width = 500;
      height = 320;
      offset = "20x42";
      origin = "bottom-right";
      font = "Noto Serif CJK SC 12";
      gap_size = 2;
      frame_width = 0;
      min_icon_size = 48;
      max_icon_size = 64;
      mouse_left_click = "do_action, close_current";
      mouse_middle_click = "close_current";
      mouse_right_click = "context";
      vertical_alignment = "top";
      show_indicators = "no";
      dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst";
    };

    urgency_low = {
      background = colors.white;
      foreground = colors.background;
      frame_color = colors.disabled;
      timeout = 10;
      format = mkFormat colors.secondary;
    };

    urgency_normal = {
      background = colors.white;
      foreground = colors.background;
      frame_color = colors.secondary;
      format = mkFormat colors.primary;
      timeout = 10;
    };

    urgency_critical = {
      background = colors.alert;
      foreground = colors.white;
      timeout = 60;
      format = mkFormat colors.white;
    };
  };

}
