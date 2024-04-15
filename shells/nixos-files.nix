{ ... }:
{
  "tikv-dev" = {
    target = "shells/tikv-dev";
    # FIXME: not hard-code here.
    source = ./tikv-dev;
  };
  "tidb-dev" = {
    target = "shells/go-general-dev";
    source = ./go-general-flake;
  };
  "rocksdb-dev" = {
    target = "shells/rocksdb-dev";
    source = ./rocksdb-flake;
  };
}
