{
  description = "Root system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nur.url = "github:nix-community/NUR";
    polypane.url = "github:mahmoud-moursy/polypane-flake";

    impermanence.url = "github:nix-community/impermanence";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    user-passwords = {
      url = "path:users/passwords";
      flake = false;
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      ...
    }:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      nixosConfigurations = {

        moursy-nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./software/steam.nix

            inputs.nixos-hardware.nixosModules.asus-rog-strix-x570e
            inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
            inputs.nixos-hardware.nixosModules.common-pc-ssd
            ./hardware/nvidia.nix
            ./hardware/boot-configuration.nix

            home-manager.nixosModules.home-manager
            ./users

            inputs.impermanence.nixosModules.impermanence
            ./impermanence.nix

            inputs.disko.nixosModules.disko
            ./hardware/disko.nix
          ];

          specialArgs = {
            inherit inputs;
          };
        };
      };
    };
}
