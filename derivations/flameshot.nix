{ stdenv
, fetchFromGitHub
, qtbase
, qttools
, qtsvg
, wrapQtAppsHook
, cmake
, nix-update-script
, fetchpatch
, kguiaddons
}:

stdenv.mkDerivation {
  pname = "flameshot-hyprland";
  version = "nightly";

  src = fetchFromGitHub {
    owner = "flameshot-org";
    repo = "flameshot";
    rev = "master";
    sha256 = "sha256-5rckIuxtB4niCpxslZ6pQkTNwLeH3wcBImWmUa1KtZg=";
  };

  patches = [
    # https://github.com/flameshot-org/flameshot/pull/3166
    (fetchpatch {
      name = "10-fix-wayland.patch";
      url = "https://github.com/flameshot-org/flameshot/commit/5fea9144501f7024344d6f29c480b000b2dcd5a6.patch";
      sha256 = "sha256-SnjVbFMDKD070vR4vGYrwLw6scZAFaQA4b+MbI+0W9E=";
    })
  ];

  passthru = {
    updateScript = nix-update-script { };
  };
  cmakeFlags = [ "-DUSE_WAYLAND_GRIM=1" "-DUSE_WAYLAND_CLIPBOARD=1" ];

  nativeBuildInputs = [ cmake kguiaddons qttools qtsvg wrapQtAppsHook ];
  buildInputs = [ qtbase ];
}
