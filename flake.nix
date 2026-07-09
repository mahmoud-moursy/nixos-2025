{
  description = "Root system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote.url = "github:nix-community/lanzaboote/v1.1.0";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    user-passwords = {
      url = "path:users/passwords";
      flake = false;
    };

    service-passwords = {
      url = "path:services/passwords";
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
      nixosConfigurations.moursy-x570 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./desktops/cosmic.nix

          ./software/steam.nix

          ./services/openssh
          ./services/avahi
          ./services/syncthing

          home-manager.nixosModules.home-manager
          ./users

          inputs.nixos-hardware.nixosModules.asus-rog-strix-x570e
          inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
          inputs.nixos-hardware.nixosModules.common-pc-ssd
          inputs.lanzaboote.nixosModules.lanzaboote
          inputs.disko.nixosModules.disko
          inputs.impermanence.nixosModules.impermanence

          ./hardware/x570/razer.nix
          ./hardware/x570/nvidia.nix
          ./hardware/x570/boot-configuration.nix
          ./hardware/x570/lanzaboote.nix
          ./hardware/x570/disko.nix
          ./hardware/x570/impermanence.nix
          ./hardware/x570/network.nix
        ];

        specialArgs = {
          inherit inputs;
        };
      };

      nixosConfigurations.moursy-alienware = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix

          ./services/allow-local.nix
          ./services/insomnia.nix

          ./services/caddy
          
          ./services/technitium

          ./services/openssh
          ./services/openssh/allow-login.nix

          ./services/avahi
          ./services/avahi/publish.nix

          ./services/syncthing
          ./services/syncthing/allow-remote.nix

          ./services/vaultwarden

          home-manager.nixosModules.home-manager
          ./users

          ./hardware/alienware/boot-configuration.nix
          ./hardware/alienware/nvidia.nix
          ./hardware/alienware/disks.nix
          ./hardware/alienware/network.nix
        ];

        specialArgs = {
          inherit inputs;
        };
      };
    };
}
