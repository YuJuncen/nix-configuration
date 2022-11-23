{ pkgs ? import <nixpkgs> { }, unstable ? import <nixpkgs-unstable> { }, ... }:
let
  tikv-deps = with pkgs;
    [
      cmake
      gnumake
      protobuf
      clang
      rustup
      gdb
    ];
  tidb-deps = with unstable; [
    go-tools
    gopls
    go-outline
    gocode
    gopkgs
    gocode-gomod
    godef
    golint
    delve
    impl
    mockgen
    bazel-gazelle

    go_1_19
  ];
in
pkgs.mkShell {
  name = "TiDEV";
  packages =
    tikv-deps ++ tidb-deps ++ [ pkgs.fish ];
  shellHook = ''
    export PATH=$PATH:$HOME/.cargo/bin:$HOME/go/bin
    export HTTP_PROXY=http://127.0.0.1:1080
    export HTTPS_PROXY=$HTTP_PROXY
    export GOROOT=$(go env GOROOT)
    bold=$'\e[1m'
    reset=$'\e[0m'
    echo "PROXY=$bold$HTTP_PROXY$reset; Happy Hacking!"
  '';
}
