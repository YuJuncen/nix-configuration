{
  description = "Hillium's personal NixOS configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    "home-manager" = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@attrs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

    nixosConfigurations."structure" =
      let system = "x86_64-linux";
      in
      nixpkgs.lib.nixosSystem {
        specialArgs = attrs // {
          # hyprland-flake =
          #   let
          #     flake-compat = builtins.fetchTarball {
          #       url = "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
          #       sha256 = "1prd9b1xx8c0sfwnyzkspplh30m613j42l1k789s521f4kv4c2z2";
          #     };
          #   in
          #   (import flake-compat {
          #     src = builtins.fetchTarball {
          #       url = "https://github.com/hyprwm/Hyprland/archive/refs/tags/v0.28.0.zip";
          #       sha256 = "1ipg3f1js291vyh9888qsy5hgqqj10m8zzc1y8i1ihgikyzsqlmp";
          #     };
          #   }).defaultNix;
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
            overlayConfig = { nixpkgs, ... }: rec {
              nixpkgs.overlays =
                let
                  add-custom-derivations = self: super: {
                    rofi-nord-theme = import ./derivations/rofi-nord-theme super;
                    mono-gtk-theme = import ./derivations/mono-gtk-theme { pkgs = super; };
                    flameshot-hyprland = import ./derivations/flameshot super;
                  };
                in
                [ add-custom-derivations ];
            };
          in
          [
            overlayConfig
            ./configuration.nix
            ./uncommon/hardware-config.nix
          ];
      };
  };
}
