{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    "home-manager".url = github:nix-community/home-manager;
  };

  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ ./configuration.nix
                  ./home.nix
                  ./uncommon/hardware-config.nix
                ];
    };
  };
}
