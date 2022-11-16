{ pkgs ? import <nixpkgs> { }, unstable ? import <nixpkgs-unstable> { }, ... }:
pkgs.mkShell {
  name = "TiDEV";
  packages = with pkgs; [
    cmake
    gnumake
    protobuf
    clang
    rustup
    gdb
    fish
  ] ++
  [
    unstable.go_1_19
  ];
  shellHook = ''
    export PATH=$PATH:$HOME/.cargo/bin:$HOME/go/bin
    export HTTP_PROXY=http://127.0.0.1:1080
    export HTTPS_PROXY=$HTTP_PROXY
    bold=$'\e[1m'
    reset=$'\e[0m'
    echo "PROXY=$bold$HTTP_PROXY$reset; Change it if need."
  '';
}
