{ pkgs, ... }:

{
  enable = true;
  greeters.gtk = {
    enable = true;
    theme = {
      package = pkgs.fluent-gtk-theme;
      name = "Fluent";
    };
    indicators = [ "~clock" "~spacer" "~session" ];
  };
}
