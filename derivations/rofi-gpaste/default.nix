{ pkgs, ... }:
with pkgs;
stdenv.mkDerivation {
  name = "rofi-gpaste";
  buildInput = [ xdotool gnome.gpaste gnome.zenity ];
  src = fetchFromGitHub {
    owner = "yusufaktepe";
    repo = "rofi-gpaste";
    rev = "cef70a76c7c42b3ec98deafcf85f8e2d164a6d1e";
    hash = "sha256-IGAgGxq/ffH0xy2z1+3vh0rSi9cV3MNAIuKFTSNJVr4=";
  };

  buildPhase = "true";
  installPhase = ''
    mkdir -p $out/bin
    sed -i "s|xdotool|${xdotool}/bin/xdotool|g" rofi-gpaste
    sed -i "s|gpaste-client|${gnome.gpaste}/bin/gpaste-client|g" rofi-gpaste
    sed -i "s|zenity|${gnome.zenity}/bin/zenity|g" rofi-gpaste
    cp -r rofi-gpaste $out/bin/rofi-gpaste
  '';
}
