pkgs:
with pkgs;
derivation {
  inherit busybox;

  name = "rofi-nord-theme";
  system = "x86_64-linux";
  src = ./nord.rasi;
  builder = "${pkgs.bash}/bin/bash";
  args = [ ./build.sh ];
}
