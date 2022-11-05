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
      specialArgs = attrs;
      modules =
        let
          overlayConfig = { nixpkgs, ... }: rec {
            nixpkgs.overlays =
              let
                add-rofi-nord-theme = _self: super: with super; {
                  rofi-nord-theme = import ./derivations/rofi-nord-theme super;
                };
              in
              [ add-rofi-nord-theme ];
          };
        in
        [
          ./configuration.nix
          overlayConfig
          ./home.nix
          ./uncommon/hardware-config.nix
        ];
    };
  };
}
