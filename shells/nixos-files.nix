{
  "tidev.nix" = {
    target = "shells/tidev.nix";
    source = ./tidb-dev/tidev.nix;
  };
  "go.nix" = {
    target = "shells/go.nix";
    source = ./go-generic.nix;
  };
}
