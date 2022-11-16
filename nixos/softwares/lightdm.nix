{ pkgs, ... }:

{
  enable = true;
  greeters.gtk = {
    enable = true;
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis";
    };
    indicators = [ "~clock" "~spacer" "~session" ];
    extraConfig = ''
      xfg-dpi = 192
    '';
  };
}
