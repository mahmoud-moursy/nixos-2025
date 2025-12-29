all@{ pkgs, inputs, ... }:
{
  users.mutableUsers = false;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  imports = [
    (import ./root.nix all)
    (import ./moursy.nix all)
  ];
}
