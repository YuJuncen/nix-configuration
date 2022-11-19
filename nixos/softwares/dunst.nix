# Put into home manager -> home.services.dunst.
{ colors, ... }:
{
  enable = true;
  settings = {
    global = {
      width = 300;
      height = 300;
      offset = "50x80";
      origin = "bottom-right";
      transparency = 10;
      font = "Noto Serif CJK SC 8";
      format = "%a <b>%s</b>\n%b";
      frame_width = 2;
      gap_size = 2;
    };

    urgency_low = {
      background = colors.background;
      foreground = colors.foreground;
      flame_color = colors.disabled;
      timeout = 10;
    };

    urgency_normal = {
      background = colors.background;
      foreground = colors.white;
      flame_color = colors.primary;
      timeout = 10;
    };

    urgency_critical = {
        background = colors.alert;
        foreground = colors.white;
      timeout = 60;
    };
  };

}
