{
  description = "Hillium's personal NixOS configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    "home-manager" = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@attrs:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;


      nixosConfigurations."structure" =
        let system = "x86_64-linux";
        in
        nixpkgs.lib.nixosSystem rec {
          specialArgs = attrs // {
            colors = import ./nixos/color.nix;
            unstable = import nixpkgs-unstable {
              inherit system;
              config = {
                allowUnfree = true;
              };
            };
          };
          modules =
            let
              overlayConfig = { nixpkgs, ... }: {
                nixpkgs.overlays =
                  let
                    add-custom-derivations = self: super: {
                      rofi-nord-theme = import ./derivations/rofi-nord-theme super;
                      mono-gtk-theme = import ./derivations/mono-gtk-theme { pkgs = super; };
                      yesplaymusic = import ./derivations/yesplaymusic super;
                    };
                  in
                  [ add-custom-derivations ];
              };
            in
            [
              overlayConfig
              ./configuration.nix
              ./uncommon/hardware-config.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.users."hillium".imports = [
                  attrs.hyprland.homeManagerModules.default
                  ./nixos/home.nix
                ];
                home-manager.extraSpecialArgs = {
                  colors = import ./nixos/color.nix;
                  unstable = specialArgs.unstable;
                };
              }
            ];
        };
    };
}
