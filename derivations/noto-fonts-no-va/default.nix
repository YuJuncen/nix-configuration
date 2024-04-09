
{ stdenvNoCC, lib, fetchFromGitHub, ... }: rec {
mkNotoCJK = { typeface, version, sha256 }:
    stdenvNoCC.mkDerivation {
      pname = "noto-fonts-cjk-${lib.toLower typeface}";
      inherit version;

      src = fetchFromGitHub {
        owner = "googlefonts";
        repo = "noto-cjk";
        rev = "${typeface}${version}";
        inherit sha256;
      };

      installPhase = ''
        install -m444 -Dt $out/share/fonts/opentype/noto-cjk ${typeface}/OTF/SimplifiedChinese/*.otf
      '';
    };

  sans = mkNotoCJK {
    typeface = "Sans";
    version = "2.004";
    sha256 = "sha256-IgalJkiOAVjNxKaPAQWfb5hKeqclliR4qVXCq63FGWY=";
  };

  serif = mkNotoCJK {
    typeface = "Serif";
    version = "2.002";
    sha256 = "sha256-GLjpTAiHfygj1J4AdUVDJh8kykkFOglq+h4kyat5W9s=";
  };
}