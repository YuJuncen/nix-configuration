{ pkgs, ... }:

{
  enable = true;
  greeters.gtk = {
    enable = true;
    theme = {
      package = pkgs.mono-gtk-theme;
      name = "MonoThemeDark";
    };
    indicators = [ "~clock" "~spacer" "~session" ];
  };
}
