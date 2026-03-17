{
  description = "Root system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";
    
    polypane.url = "github:mahmoud-moursy/polypane-flake"; 
    polypane.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    
    lanzaboote.url = "github:nix-community/lanzaboote/v1.0.0";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

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
            ./hardware/razer.nix
            ./hardware/nvidia.nix
            ./hardware/boot-configuration.nix
            
            inputs.lanzaboote.nixosModules.lanzaboote
            ./hardware/lanzaboote.nix

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
