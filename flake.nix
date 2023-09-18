{
  description = "Hillium's personal NixOS configuration.";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.11;
    "home-manager".url = github:nix-community/home-manager;
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixos-unstable;
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@attrs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

    nixosConfigurations."nixos" = let system = "x86_64-linux";
    in
    nixpkgs.lib.nixosSystem {
      specialArgs = attrs // { 
        colors = import ./nixos/color.nix; 
        nixpkgs = import nixpkgs { inherit system; };
        unstable = import nixpkgs-unstable { 
          inherit system; 
          config = {
            allowUnfree = true;
          };
        };
      };
      modules =
        let
          overlayConfig = { nixpkgs, ... }: rec {
            nixpkgs.overlays =
              let
                add-custom-derivations = _self: super: with super; {
                  rofi-nord-theme = import ./derivations/rofi-nord-theme super;
                  mono-gtk-theme = import ./derivations/mono-gtk-theme { pkgs = super; };
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
