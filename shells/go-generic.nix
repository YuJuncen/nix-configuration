{ pkgs ? import <nixpkgs-unstable> { }, ... }:
with pkgs; pkgs.mkShell {
  package = [
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

    go_1_21
  ];
  shellHook = ''
    export PATH=$PATH:$HOME/.cargo/bin:$HOME/go/bin
    export HTTP_PROXY=http://127.0.0.1:1080
    export HTTPS_PROXY=$HTTP_PROXY
    export GOROOT=$(go env GOROOT)
  '';
}
