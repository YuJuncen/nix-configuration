{
  description = "Devshell for rocksdb.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
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
          devShell = pkgs.mkShell {
            hardeningDisable = [ "all" ];
            nativeBuildInputs = with pkgs;[ cmake pkg-config gcc ];
            buildInputs = with pkgs;[ git gnumake zlib mold zstd lz4 gflags gdb ];
            PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.lz4.dev}/lib/pkgconfig:${pkgs.zstd.dev}/lib/pkgconfig";
            CC="${pkgs.gcc}/bin/cc";
            CXX="${pkgs.gcc}/bin/g++";
            shellHook = ''
            export CC="${pkgs.gcc}/bin/cc";
            export CXX="${pkgs.gcc}/bin/g++";
            export CXXFLAGS="-include cstdint";
            echo "CMAKE FLAGS HINT: -DWITH_ZSTD=1 -DWITH_LZ4=1 -DFAIL_ON_WARNINGS=OFF -DCMAKE_CXX_STANDARD=20"
            '';
          };
        }
      );
}
