{ ... }: {
	users.mutableUsers = false;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

	imports = [
		./root.nix
		./moursy.nix
	];
}
