{ tikv-dev, ... } @ ctx:
{
  "tikv-dev" = {
    target = "shells/tikv-dev";
    # FIXME: not hard-code here.
    source = tikv-dev;
  };
  "tidb-dev" = {
    target = "shells/tidb-dev";
    source = ./tidb-flake;
  };
  "rocksdb-dev" = {
    target = "shells/rocksdb-dev";
    source = ./rocksdb-flake;
  };
}
