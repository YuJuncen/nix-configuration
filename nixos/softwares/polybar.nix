{ pkgs, ... }:

{
  service = {
    package = pkgs.polybar;
    enable = true;
    script = ''
      polybar &
    '';
  };
}
