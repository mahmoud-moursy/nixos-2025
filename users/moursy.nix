{ ... }:
{
  users.users.moursy.hashedPasswordFile = "${passwords/moursy.secret}";

  users.users.moursy = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  home-manager.users.moursy = ./home/moursy.nix;
}
