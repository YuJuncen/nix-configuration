{
  description = "Hillium's personal NixOS configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    "home-manager" = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
      flake = true;
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@attrs:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;


      nixosConfigurations."structure" =
        let system = "x86_64-linux";
        in
        nixpkgs.lib.nixosSystem rec {
          specialArgs = attrs // {
            colors = import ./home-manager/color.nix;
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
                      apple-fonts = import ./derivations/apple-fonts.nix super;
                      noto-fonts-no-va = import ./derivations/noto-fonts-no-va super;
                      rofi-gpaste = import ./derivations/rofi-gpaste super;
                      goldendict-ng-debug = import ./derivations/goldendict-ng-debug.nix super;
                    };
                    feishu-latest = self: super: {
                      feishu = super.feishu.overrideAttrs (_: rec {
                        version = "7.11.9";
                        packageHash = "ec62a2df";
                        src = builtins.fetchurl {
                          url = "https://sf3-cn.feishucdn.com/obj/ee-appcenter/${packageHash}/Feishu-linux_x64-${version}.deb";
                          sha256 = "1c4ggcq10knb1gac6rmlb5mdxlz1xrz6i735mfqinvr7qfrqzi4q";
                        };
                      });
                    };
                  in
                  [ add-custom-derivations feishu-latest ];
              };
            in
            [
              overlayConfig
              ./nixos
              ./uncommon/hardware-config.nix
              ./uncommon/nvidia.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.users."hillium".imports = [
                  ./home-manager/home.nix
                ];
                home-manager.extraSpecialArgs = {
                  colors = import ./home-manager/color.nix;
                } // specialArgs;
              }
            ];
        };
    };
}
