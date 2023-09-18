{
  description = "Hillium's personal NixOS configuration.";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-23.05;
    "home-manager" = {
      url = github:nix-community/home-manager/release-23.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixos-unstable;
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@attrs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

    nixosConfigurations."structure" =
      let system = "x86_64-linux";
      in
      nixpkgs.lib.nixosSystem {
        specialArgs = attrs // {
          hyprland-flake =
            let
              flake-compat = builtins.fetchTarball {
                url = "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
                sha256 = "1prd9b1xx8c0sfwnyzkspplh30m613j42l1k789s521f4kv4c2z2";
              };
            in
            (import flake-compat {
              src = builtins.fetchTarball {
                url = "https://github.com/hyprwm/Hyprland/releases/download/v0.29.1/source-v0.29.1.tar.gz";
                sha256 = "0s68sfzx1aiaxhpkm25jyl53gbqyc9ccsiymd3k934kgi7mj6zw4";
              };
            }).defaultNix;
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
