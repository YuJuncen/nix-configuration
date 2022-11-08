# Place: home manager.

{ pkgs, ... }:

{
  package = pkgs.polybar.override {
    i3GapsSupport = true;
    githubSupport = true;
    i3Support = true;
  };

  config = ./config.ini;
  extraConfig = ''
    [module/fcitx]
    type = custom/script
    exec = ${./polybar-fcitx5-script.sh}
    tail = true
    interval = 0
  '';

  enable = true;
  script = ''
    polybar --version
    polybar primary &
  '';
}
