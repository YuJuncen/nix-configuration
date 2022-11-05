# ???

This is a personal config, in very early stage.

Some of configurations (e.g. `i3` window manager) are added manually, hence the configuration is probably unformed if build the OS with solely these configs.

## Memos

Generate the hardware config:

```shell
nixos-generate-config --show-hardware-config > hardwares/hardware-config.nix
```

Build the system via the config:

```shell
nixos-rebuild switch --flake ".#"
```