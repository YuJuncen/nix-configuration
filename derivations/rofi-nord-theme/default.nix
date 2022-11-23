{ pkgs ? import <nixpkgs> { }, colors ? import ../../nixos/color.nix, ... }:
with pkgs;
let
  mkGlobCss = item:
    let
      keys = builtins.attrNames item;
      go = accu: next: "${accu}\n${next}: ${builtins.getAttr next item};";
      inner = builtins.foldl' go "" keys;
    in
    "* {\n${inner}\n}\n";
in
derivation {
  inherit busybox;

  name = "rofi-nord-theme";
  system = "x86_64-linux";
  src = ./nord.rasi;

  COLOR_SCHEMA = builtins.toFile "color-schema.rasi" (mkGlobCss colors);
  builder = "${pkgs.bash}/bin/bash";
  args = [ ./build.sh ];
}
