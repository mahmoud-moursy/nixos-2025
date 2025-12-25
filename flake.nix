{
  description = "Root system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    
    impermanence.url = "github:nix-community/impermanence";
    
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    disko = {
    	url = "github:nix-community/disko/latest";
    	inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nix-mineral = {
        url = "github:cynicsketch/nix-mineral";
        flake = false;
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, disko, impermanence, nix-mineral, nixos-hardware, nur, self }:
  {
    nixosConfigurations = {

      moursy-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
		./configuration.nix
		
		nixos-hardware.nixosModules.asus-rog-strix-x570e
		nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
		nixos-hardware.nixosModules.common-pc-ssd
		./hardware/nvidia.nix
		./hardware/boot-configuration.nix
		
		home-manager.nixosModules.home-manager
		./users
        
		"${nix-mineral}/nix-mineral.nix"
		
		impermanence.nixosModules.impermanence
		./impermanence.nix
	
        	disko.nixosModules.disko
        	./hardware/disko.nix
        ];
        
        specialArgs = {
            	inherit inputs;
        };
      };
    };
  };
}
