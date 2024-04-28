{ pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs;  [
      acl
      attr
      bzip2
      curl
      expat
      fuse3
      icu
      libsodium
      libssh
      libxml2
      lz4
      nss
      openssl
      stdenv.cc.cc
      stdenv.cc.cc.lib
      systemd
      util-linux
      xz
      zlib
      zstd
    ];
  };
}