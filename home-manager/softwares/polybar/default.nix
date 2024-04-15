# Place: home manager.

{ pkgs, ... }:

{
  package = pkgs.polybar.override {
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
    export PATH=$PATH:${pkgs.i3}/bin
    polybar primary &
  '';
}
