{
  description = "Distributed transactional key-value database, originally created to complement TiDB";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem
      (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ rust-overlay.overlays.default ];
          };
          python = pkgs.python3;
          python-env = python.withPackages (p: with p; [
            redis
          ]);
        in
        {
          devShell = pkgs.mkShell {
            hardeningDisable = [ "all" ];
            # We added rustup for making some scripts happy...
            buildInputs = with pkgs;[ cmake pkg-config python-env gcc zsh git gnumake protobuf3_8 perl zlib openssl rustup ];
            PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
            PROTOC = "${pkgs.protobuf3_8}/bin/protoc";
            shellHook = ''
              PYTHONPATH=${python-env}/${python-env.sitePackages}
            '';
          };
        }
      );
}
