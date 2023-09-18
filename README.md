# ???

This is a personal config, in very early stage.

Some of configurations are added manually, hence the configuration is probably unformed if build the OS with solely these configs.

## Memos

Generate the hardware config:

```shell
nixos-generate-config --show-hardware-config > hardwares/hardware-config.nix
```

Build the system via the config:

```shell
nixos-rebuild switch --flake ".#structure"
```

Format the codebase (is there any CI?)

```shell
nix fmt
```