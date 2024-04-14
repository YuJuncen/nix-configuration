
{ stdenvNoCC, fetchzip, ... }: {
  serif = stdenvNoCC.mkDerivation {
      pname = "noto-fonts-cjk-no-va-serif";
      version = "2.004";

      src = fetchzip {
        url = "https://github.com/notofonts/noto-cjk/releases/download/Serif2.002/14_NotoSerifSC.zip";
        stripRoot = false;
        hash = "sha256-12uV18lAuQkjc4+cJU3EmgfpiwjKV0pDFQbycxRxlbw=";
      };

      buildPhase = "true";
      installPhase = ''
        install -m444 -Dt $out/share/fonts/opentype/noto-cjk SubsetOTF/SC/*.otf
      '';
    };
}