pkgs:

derivation {
    name = "rofi-nord-theme";
    system = "x86_64-linux";
    src = ./nord.rasi;
    busybox = pkgs.busybox;
    builder = "${pkgs.bash}/bin/bash";
    args = [ ./build.sh ];
}