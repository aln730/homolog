{
  description = "NixOS configs for Raspberry Pi nodes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.homolog-01 = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./modules/gatekeeper.nix
        ./hosts/homolog-01/default.nix
      ];
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
  };
}
