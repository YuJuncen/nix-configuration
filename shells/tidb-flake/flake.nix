{
  description = "A simple dev shell for tidb.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        {
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              go-tools
              gopls
              go-outline
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
              export GOROOT=$(go env GOROOT)
              export PATH=$PATH:$HOME/go/bin
            '';
          };
        }
      );
}
