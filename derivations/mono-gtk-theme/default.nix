{pkgs ? import <nixpkgs> {}, ...}:
with pkgs;
stdenv.mkDerivation {
    name = "mono-gtk-theme";
    src = fetchFromGitHub {
        owner = "witalihirsch";
        repo = "Mono-gtk-theme";
        rev = "0.8";
        hash = "sha256-as8cb8vQwC6UoU2hfu1L8+r3ilWFcNQv9FGyjrbw/pA=";
    };


    installPhase = ''
    mkdir -p $out/share/themes
    cp -r $src/MonoTheme $out/share/themes/
    cp -r $src/MonoThemeDark $out/share/themes/
    '';
}