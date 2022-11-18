{
  description = "Hillium's personal NixOS configuration.";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    "home-manager".url = github:nix-community/home-manager;
  };

  outputs = { self, nixpkgs, ... }@attrs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs // { colors = import ./nixos/color.nix; };
      modules =
        let
          overlayConfig = { nixpkgs, ... }: rec {
            nixpkgs.overlays =
              let
                add-custom-derivations = _self: super: with super; {
                  rofi-nord-theme = import ./derivations/rofi-nord-theme super;
                  mono-gtk-theme = import ./derivations/mono-gtk-theme super;
                };
              in
              [ add-custom-derivations ];
          };
        in
        [
          ./configuration.nix
          overlayConfig
          ./uncommon/hardware-config.nix
        ];
    };
  };
}
