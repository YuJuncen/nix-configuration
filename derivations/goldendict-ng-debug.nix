{ stdenv
, lib
, fetchFromGitHub
, pkg-config
, cmake
, libvorbis
, ffmpeg
, libeb
, hunspell
, opencc
, xapian
, libzim
, lzo
, xz
, tomlplusplus
, fmt
, bzip2
, libiconv
, xorg
, qt6
, wrapGAppsHook
, ...
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "goldendict-ng-debug";
  version = "23.09.10";

  src = fetchFromGitHub {
    owner = "xiaoyifang";
    repo = "goldendict-ng";
    rev = "v${finalAttrs.version}-WhiteDew.54c8bd56";
    hash = "sha256-X9xqodCqHjppz1zIHLnb87NiDE4FWlXiQufhDu/rJq4=";
  };

  nativeBuildInputs = [ pkg-config cmake qt6.wrapQtAppsHook wrapGAppsHook ];
  buildInputs = with qt6; [qtbase
    qtsvg
    qttools
    qtwebengine
    qt5compat
    qtmultimedia
    qtspeech] ++ [
    
    libvorbis
    tomlplusplus
    fmt
    hunspell
    xz
    lzo
    xorg.libXtst
    bzip2
    libiconv
    opencc
    libeb
    ffmpeg
    xapian
    libzim
  ];

  # to prevent double wrapping of wrapQtApps and wrapGApps
  dontWrapGApps = true;

  preFixup = ''
    qtWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  cmakeFlags = [
    "-DWITH_XAPIAN=ON"
    "-DWITH_ZIM=ON"
    "-DWITH_FFMPEG_PLAYER=ON"
    "-DWITH_EPWING_SUPPORT=ON"
    "-DUSE_SYSTEM_FMT=ON"
    "-DUSE_SYSTEM_TOML=ON"
  ];
})