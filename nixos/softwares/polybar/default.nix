{ pkgs, ... }:

{
  package = pkgs.polybar.override {
    i3GapsSupport = true;
    i3Support = true;
  };

  config = ./config.ini;

  enable = true;
  script = ''
    polybar primary &
  '';
}
