{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
  };

  outputs = inputs: {
    nixosConfigurations.naxior =
      let
        system = "x86_64-linux";
      in
      inputs.nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {
          flake-inputs = inputs;
        };
        modules = [
          ./naxior
        ];
      };

    devShells = inputs.nixpkgs.lib.genAttrs inputs.nixpkgs.lib.systems.flakeExposed (system: {
      default = import ./dev {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      };
    });
  };
}